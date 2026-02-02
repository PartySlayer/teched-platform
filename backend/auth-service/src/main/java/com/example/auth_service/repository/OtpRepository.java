package com.example.auth_service.repository;

import com.example.auth_service.model.Otp;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface OtpRepository extends CrudRepository<Otp, Long> {
    Optional<Otp> findFirstByEmailOrderByCreatedAtDesc(String email);
}