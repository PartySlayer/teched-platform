package com.example.auth_service.service;

import com.example.auth_service.amazonaws.EmailService;
import com.example.auth_service.model.Otp;
import com.example.auth_service.repository.OtpRepository;
import com.teched.auth.model.dto.OtpRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.Random;

@Service
public class AuthService {

    private final OtpRepository otpRepository;
    private final EmailService emailService;
    private final Random random = new Random();

    public AuthService(OtpRepository otpRepository, EmailService emailService) {
        this.otpRepository = otpRepository;
        this.emailService = emailService;
    }

    @Transactional // Garantisce l'integrità del DB
    public void processOtpRequest(OtpRequest request) {
        // 1. Generazione codice
        String otpCode = String.format("%06d", random.nextInt(1000000));

        // 2. Mapping DTO -> Entity
        Otp otpEntity = new Otp();
        otpEntity.setEmail(request.getEmail());
        otpEntity.setOtpCode(otpCode);
        otpEntity.setCreatedAt(LocalDateTime.now());
        otpEntity.setExpiresAt(LocalDateTime.now().plusMinutes(5));

        // 3. Persistenza
        otpRepository.save(otpEntity);

        // 4. Invio asincrono (idealmente)
        emailService.sendEmail(
                request.getEmail(),
                "Codice OTP",
                "Il tuo codice è: " + otpCode,
                "Codice: " + otpCode
        );
    }
}