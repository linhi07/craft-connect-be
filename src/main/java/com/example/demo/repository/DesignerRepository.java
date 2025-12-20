package com.example.demo.repository;

import com.example.demo.entity.Designer;
import com.example.demo.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface DesignerRepository extends JpaRepository<Designer, Integer> {

    Optional<Designer> findByUser(User user);

    Optional<Designer> findByUserUserId(Integer userId);

    boolean existsByUser(User user);
}
