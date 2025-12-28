package com.example.demo.service;

import com.example.demo.config.FileUploadProperties;
import com.example.demo.dto.response.FileUploadResponse;
import io.minio.*;
import io.minio.errors.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.tika.Tika;
import org.imgscalr.Scalr;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;

/**
 * Service for handling file storage with MinIO.
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class FileStorageService {

    private final MinioClient minioClient;
    private final FileUploadProperties fileUploadProperties;
    private final Tika tika = new Tika();

    /**
     * Upload a file to MinIO and return file metadata.
     */
    public FileUploadResponse uploadFile(MultipartFile file) throws IOException {
        // Validate file
        validateFile(file);

        // Create bucket if not exists
        createBucketIfNotExists();

        // Generate unique filename
        String originalFilename = file.getOriginalFilename();
        String extension = getFileExtension(originalFilename);
        String uniqueFilename = UUID.randomUUID().toString() + extension;

        // Detect content type
        String contentType = detectContentType(file);

        // Upload original file
        String fileUrl = uploadToMinio(uniqueFilename, file.getInputStream(), file.getSize(), contentType);

        // Generate thumbnail for images
        String thumbnailUrl = null;
        if (isImage(contentType)) {
            thumbnailUrl = generateAndUploadThumbnail(file, uniqueFilename);
        }

        return FileUploadResponse.builder()
                .fileUrl(fileUrl)
                .fileName(originalFilename)
                .fileSize(file.getSize())
                .fileType(contentType)
                .thumbnailUrl(thumbnailUrl)
                .build();
    }

    /**
     * Validate file size and type.
     */
    private void validateFile(MultipartFile file) {
        if (file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        // Check file size
        Long maxSize = fileUploadProperties.getFile().getMaxSize();
        if (file.getSize() > maxSize) {
            throw new IllegalArgumentException(
                    String.format("File size exceeds maximum allowed size of %d bytes", maxSize)
            );
        }

        // Check file type
        try {
            String contentType = detectContentType(file);
            if (!fileUploadProperties.getFile().getAllowedTypes().contains(contentType)) {
                throw new IllegalArgumentException(
                        String.format("File type '%s' is not allowed", contentType)
                );
            }
        } catch (IOException e) {
            throw new IllegalArgumentException("Could not detect file type", e);
        }
    }

    /**
     * Detect file content type using Apache Tika.
     */
    private String detectContentType(MultipartFile file) throws IOException {
        try (InputStream inputStream = file.getInputStream()) {
            String contentType = tika.detect(inputStream, file.getOriginalFilename());
            
            // Normalize JPEG types
            if ("image/jpg".equals(contentType)) {
                contentType = "image/jpeg";
            }
            
            // Normalize MOV types
            if ("video/quicktime".equals(contentType) || file.getOriginalFilename().toLowerCase().endsWith(".mov")) {
                contentType = "video/quicktime";
            }
            
            return contentType;
        }
    }

    /**
     * Create MinIO bucket if it doesn't exist.
     */
    private void createBucketIfNotExists() {
        try {
            String bucketName = fileUploadProperties.getBucketName();
            boolean exists = minioClient.bucketExists(
                    BucketExistsArgs.builder().bucket(bucketName).build()
            );

            if (!exists) {
                minioClient.makeBucket(
                        MakeBucketArgs.builder().bucket(bucketName).build()
                );
                log.info("Created MinIO bucket: {}", bucketName);
                
                // Set bucket policy to public read for easier access
                String policy = """
                    {
                        "Version": "2012-10-17",
                        "Statement": [
                            {
                                "Effect": "Allow",
                                "Principal": {"AWS": "*"},
                                "Action": ["s3:GetObject"],
                                "Resource": ["arn:aws:s3:::%s/*"]
                            }
                        ]
                    }
                    """.formatted(bucketName);
                
                minioClient.setBucketPolicy(
                    SetBucketPolicyArgs.builder()
                        .bucket(bucketName)
                        .config(policy)
                        .build()
                );
                log.info("Set public read policy for bucket: {}", bucketName);
            }
        } catch (Exception e) {
            log.error("Error creating bucket", e);
            throw new RuntimeException("Failed to create storage bucket", e);
        }
    }

    /**
     * Upload file to MinIO.
     */
    private String uploadToMinio(String filename, InputStream inputStream, long size, String contentType) {
        try {
            String bucketName = fileUploadProperties.getBucketName();
            
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucketName)
                            .object(filename)
                            .stream(inputStream, size, -1)
                            .contentType(contentType)
                            .build()
            );

            // Return public URL
            return String.format("%s/%s/%s", 
                    fileUploadProperties.getEndpoint(), 
                    bucketName, 
                    filename);

        } catch (Exception e) {
            log.error("Error uploading file to MinIO", e);
            throw new RuntimeException("Failed to upload file", e);
        }
    }

    /**
     * Generate and upload thumbnail for images.
     */
    private String generateAndUploadThumbnail(MultipartFile file, String originalFilename) {
        try {
            // Read image
            BufferedImage originalImage = ImageIO.read(file.getInputStream());
            if (originalImage == null) {
                log.warn("Could not read image for thumbnail generation");
                return null;
            }

            // Generate thumbnail (max 800px width/height, maintain aspect ratio)
            BufferedImage thumbnail = Scalr.resize(
                    originalImage,
                    Scalr.Method.ULTRA_QUALITY,
                    Scalr.Mode.FIT_TO_WIDTH,
                    800,
                    800,
                    Scalr.OP_ANTIALIAS
            );

            // Convert to byte array
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            String format = getImageFormat(originalFilename);
            ImageIO.write(thumbnail, format, baos);
            byte[] thumbnailBytes = baos.toByteArray();

            // Upload thumbnail
            String thumbnailFilename = "thumb_" + originalFilename;
            String thumbnailUrl = uploadToMinio(
                    thumbnailFilename,
                    new ByteArrayInputStream(thumbnailBytes),
                    thumbnailBytes.length,
                    file.getContentType()
            );

            log.info("Generated thumbnail for {}", originalFilename);
            return thumbnailUrl;

        } catch (Exception e) {
            log.error("Error generating thumbnail", e);
            return null; // Don't fail the upload if thumbnail generation fails
        }
    }

    /**
     * Check if content type is an image.
     */
    private boolean isImage(String contentType) {
        return contentType != null && contentType.startsWith("image/");
    }

    /**
     * Get file extension from filename.
     */
    private String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        return filename.substring(filename.lastIndexOf("."));
    }

    /**
     * Get image format from filename.
     */
    private String getImageFormat(String filename) {
        String extension = getFileExtension(filename).toLowerCase();
        return switch (extension) {
            case ".jpg", ".jpeg" -> "jpg";
            case ".png" -> "png";
            default -> "jpg";
        };
    }
}
