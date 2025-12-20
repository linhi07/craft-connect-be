package com.example.demo.repository;

import com.example.demo.entity.VillageMaterial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VillageMaterialRepository extends JpaRepository<VillageMaterial, Integer> {

    List<VillageMaterial> findByVillageVillageId(Integer villageId);

    List<VillageMaterial> findByMaterialMaterialId(Integer materialId);
}
