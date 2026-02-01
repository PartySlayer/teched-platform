package com.example.teched.controller;

import com.example.teched.api.EnrollmentsApi;
import com.example.teched.model.EnrollmentsPostRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class EnrollmentController implements EnrollmentsApi {

    @Override
    public ResponseEntity<Void> enrollmentsPost(EnrollmentsPostRequest request) {
        // TODO: Salva l'iscrizione nel database
        // manca relazione utente - corso - enrollment
        return ResponseEntity.status(201).build();
    }
}