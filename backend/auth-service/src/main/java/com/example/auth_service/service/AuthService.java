package com.example.auth_service.service;

import com.example.auth_service.amazonaws.EmailService;
import com.example.auth_service.model.Otp;
import com.example.auth_service.repository.OtpRepository;
import com.example.auth_service.security.JwtUtils;
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
    private final JwtUtils jwtUtils;

    public AuthService(OtpRepository otpRepository, EmailService emailService, JwtUtils jwtUtils) {
        this.otpRepository = otpRepository;
        this.emailService = emailService;
        this.jwtUtils = jwtUtils;
    }

    public String verifyOtp(String email, String code) {
        // 1. Cerca l'ultimo OTP generato per quella email
        return otpRepository.findFirstByEmailOrderByCreatedAtDesc(email)
                .map(otp -> {
                    System.out.println(otp.getOtpCode() + " Questo è l'otp nel db");
                    // 2. Controlla se il codice coincide e se non è scaduto
                    boolean isValid = otp.getOtpCode().equals(code);
                    boolean isNotExpired = otp.getExpiresAt().isAfter(LocalDateTime.now());
                    System.out.println(isValid);

                    if (isValid && isNotExpired) {
                        // Opzionale: cancella l'OTP dopo l'uso o marcalo come usato
                        otpRepository.delete(otp);
                        return jwtUtils.generateToken(email);
                    }
                    return null;
                })
                .orElse(null);
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
        System.out.println(otpCode + "Questo è l'otp");
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