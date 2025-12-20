package com.example.demo.repository;

import com.example.demo.entity.CraftVillage;
import com.example.demo.entity.User;
import com.example.demo.enums.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.Set;

@Repository
public interface CraftVillageRepository extends JpaRepository<CraftVillage, Integer>, JpaSpecificationExecutor<CraftVillage> {

    Optional<CraftVillage> findByUser(User user);

    Optional<CraftVillage> findByUserUserId(Integer userId);

    List<CraftVillage> findByRegion(Region region);

    List<CraftVillage> findByScale(Scale scale);

    @Query("SELECT DISTINCT v FROM CraftVillage v " +
            "WHERE (:scale IS NULL OR v.scale = :scale) " +
            "AND (:region IS NULL OR v.region = :region)")
    List<CraftVillage> findByScaleAndRegion(
            @Param("scale") Scale scale,
            @Param("region") Region region
    );

    boolean existsByUser(User user);
}
