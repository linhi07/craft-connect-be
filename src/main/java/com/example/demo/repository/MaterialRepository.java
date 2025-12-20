package com.example.demo.repository;

import com.example.demo.entity.Material;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MaterialRepository extends JpaRepository<Material, Integer> {

    Optional<Material> findByMaterialName(String materialName);

    boolean existsByMaterialName(String materialName);
}
