buildscript {
	dependencies {
		classpath("org.flywaydb:flyway-database-postgresql:11.7.2")
		classpath("org.postgresql:postgresql:42.7.8")
	}
}

plugins {
	java
	id("org.springframework.boot") version "3.5.9"
	id("io.spring.dependency-management") version "1.1.7"
	id("org.flywaydb.flyway") version "11.7.2"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"
description = "Demo project for Spring Boot"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(17)
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-data-jpa")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation("org.springframework.boot:spring-boot-starter-web")
	implementation("org.springframework.boot:spring-boot-starter-validation")
	implementation("org.springframework.boot:spring-boot-starter-websocket")
	
	// PostgreSQL
	runtimeOnly("org.postgresql:postgresql")
	
	// Flyway
	implementation("org.flywaydb:flyway-core")
	implementation("org.flywaydb:flyway-database-postgresql")
	
	// JWT
	implementation("io.jsonwebtoken:jjwt-api:0.12.6")
	runtimeOnly("io.jsonwebtoken:jjwt-impl:0.12.6")
	runtimeOnly("io.jsonwebtoken:jjwt-jackson:0.12.6")
	
	// Jackson for Java 8 date/time
	implementation("com.fasterxml.jackson.datatype:jackson-datatype-jsr310")
	
	// MinIO for object storage
	implementation("io.minio:minio:8.5.7")
	
	// Image processing
	implementation("org.imgscalr:imgscalr-lib:4.2")
	
	// File type detection
	implementation("org.apache.tika:tika-core:2.9.1")
	
	// Lombok
	compileOnly("org.projectlombok:lombok")
	annotationProcessor("org.projectlombok:lombok")
	
	// QueryDSL
	implementation("com.querydsl:querydsl-jpa:5.1.0:jakarta")
	annotationProcessor("com.querydsl:querydsl-apt:5.1.0:jakarta")
	annotationProcessor("jakarta.annotation:jakarta.annotation-api")
	annotationProcessor("jakarta.persistence:jakarta.persistence-api")
	
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testImplementation("org.springframework.security:spring-security-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

// Flyway Gradle Plugin Configuration
flyway {
	url = "jdbc:postgresql://localhost:5433/vietnam_artisan"
	user = "postgres"
	password = "postgres"
	locations = arrayOf("filesystem:src/main/resources/db/migration")
	baselineOnMigrate = true
	baselineVersion = "0"
	cleanDisabled = false
}

tasks.withType<Test> {
	useJUnitPlatform()
}
