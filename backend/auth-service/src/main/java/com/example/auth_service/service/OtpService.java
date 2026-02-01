package com.example.auth_service.service;

import org.springframework.stereotype.Service;

@Service
public class OtpService {

    private String otpCode;

    public String generateOtp(){
        otpCode = String.valueOf((int) (Math.random() * 8999) + 1000);
        return otpCode;
    }
}
