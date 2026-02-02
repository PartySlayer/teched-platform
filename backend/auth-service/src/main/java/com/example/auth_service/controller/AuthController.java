package com.example.auth_service.controller;

import com.example.auth_service.service.AuthService;
import com.teched.auth.model.dto.OtpRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/auth")
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
}