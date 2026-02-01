package com.example.auth_service.controller;

import com.example.auth_service.amazonaws.EmailService;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
@CrossOrigin(origins = "http://localhost:3000") // Permette al frontend Next.js di comunicare
public class AuthController {

    private final EmailService emailService;

    public AuthController(EmailService emailService) {
        this.emailService = emailService;
    }

    // Cambia in PostMapping per ricevere il JSON dal frontend
    @PostMapping("/auth/otp/request")
    public String requestOtp(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        try {
            // Usa il servizio email che hai spostato nel package corretto
            emailService.sendEmail(email, "Il tuo codice OTP", "<h1>Codice: 123456</h1>", "Codice: 123456");
            return "Email inviata correttamente a: " + email;
        } catch (Exception e) {
            return "Errore: " + e.getMessage();
        }
    }
}