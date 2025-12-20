package com.example.demo.repository;

import com.example.demo.entity.PortfolioItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PortfolioItemRepository extends JpaRepository<PortfolioItem, Integer> {

    List<PortfolioItem> findByVillageVillageId(Integer villageId);

    void deleteByVillageVillageIdAndPortfolioId(Integer villageId, Integer portfolioId);
}
