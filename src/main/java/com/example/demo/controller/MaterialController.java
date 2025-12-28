package com.example.demo.controller;

import com.example.demo.entity.Material;
import com.example.demo.repository.MaterialRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/materials")
@RequiredArgsConstructor
public class MaterialController {

    private final MaterialRepository materialRepository;

    /**
     * Get all materials for dropdown selection.
     */
    @GetMapping
    public ResponseEntity<List<Material>> getAllMaterials() {
        List<Material> materials = materialRepository.findAll();
        return ResponseEntity.ok(materials);
    }
}
