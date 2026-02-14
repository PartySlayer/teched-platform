package com.example.auth_service.security;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtUtils {

    @Value("${app.jwt.secret}")
    private String jwtSecret;

    @Value("${app.jwt.expiration-ms}")
    private int jwtExpirationMs;

    public String generateToken(String email) {
        return Jwts.builder()
                .setSubject(email) // Il "soggetto" del token (l'utente)
                .setIssuedAt(new Date()) // Data di creazione
                .setExpiration(new Date((new Date()).getTime() + jwtExpirationMs)) // Scadenza
                .signWith(SignatureAlgorithm.HS256, jwtSecret) // Firma con algoritmo HS256
                .compact(); // Genera la stringa finale
    }
    public String getEmailFromToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(jwtSecret)
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(jwtSecret).build().parseClaimsJws(token);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
