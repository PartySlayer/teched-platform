package com.example.auth_service.controller;

import com.example.auth_service.service.AuthService;
import com.teched.auth.model.dto.AuthResponse;
import com.teched.auth.model.dto.OtpRequest;
import com.teched.auth.model.dto.OtpVerifyRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/v1/auth")
@CrossOrigin(origins = "http://localhost:3000")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/otp/request")
    public ResponseEntity<?> requestOtp(@RequestBody OtpRequest request) {

        authService.processOtpRequest(request);

        return ResponseEntity.ok(Map.of(
                "status", "success",
                "message", "OTP sent to " + request.getEmail()
        ));
    }
    @PostMapping("/otp/verify")
    public ResponseEntity<?> verifyOtp(@RequestBody OtpVerifyRequest request) {
        // 1. Chiamata al servizio usando i dati estratti dal body della richiesta
        String token = authService.verifyOtp(request.getEmail(), request.getOtp());

        if (token != null) {
            return ResponseEntity.ok(new AuthResponse(token));
        } else {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of(
                    "status", "error",
                    "message", "Invalid or expired OTP"
            ));
        }
    }
}
