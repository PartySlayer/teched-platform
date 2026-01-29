package com.example.teched.controller;

import com.example.teched.api.AuthApi;
import com.example.teched.model.AuthOtpRequestPostRequest;
import com.example.teched.model.AuthOtpVerifyPostRequest;
import com.example.teched.model.AuthOtpVerifyPost200Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AuthController implements AuthApi {

    @Override
    public ResponseEntity<Void> authOtpRequestPost(AuthOtpRequestPostRequest request) {
        // TODO: Genera OTP e invia email a request.getEmail()
        System.out.println("Richiesto OTP per: " + request.getEmail());
        return ResponseEntity.accepted().build();
    }

    @Override
    public ResponseEntity<AuthOtpVerifyPost200Response> authOtpVerifyPost(AuthOtpVerifyPostRequest request) {
        // TODO: Verifica se l'OTP è corretto
        AuthOtpVerifyPost200Response response = new AuthOtpVerifyPost200Response();
        response.setToken("mock-jwt-token-per-" + request.getEmail());
        return ResponseEntity.ok(response);
    }
}