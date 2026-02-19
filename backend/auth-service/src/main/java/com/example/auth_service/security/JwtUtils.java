package com.example.auth_service.security;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class JwtUtils {

    @Value("${app.jwt.secret}") // Legge la password segreta dal file application.properties
    private String jwtSecret;

    @Value("${app.jwt.expiration-ms}") // Legge quanto tempo deve durare il token (es. 24 ore)
    private int jwtExpirationMs;

    // Crea un nuovo "pass" (token) per l'utente che ha appena fatto il login
    public String generateToken(String email) {
        return Jwts.builder()
                .setSubject(email) // Scrive l'email dell'utente dentro il token
                .setIssuedAt(new Date()) // Segna l'ora di creazione
                .setExpiration(new Date((new Date()).getTime() + jwtExpirationMs)) // Imposta la scadenza
                .signWith(SignatureAlgorithm.HS256, jwtSecret) // Firma il token per evitare manomissioni
                .compact(); // Chiude il pacchetto e lo trasforma in una stringa
    }

    // Apre il token ricevuto dal Frontend e legge chi è l'utente
    public String getEmailFromToken(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(jwtSecret) // Usa la chiave segreta per "decifrare" la firma
                .build()
                .parseClaimsJws(token)
                .getBody()
                .getSubject(); // Estrae l'email (il Subject)
    }

    // Verifica se il token è ancora valido o se è scaduto/manomesso
    public boolean validateToken(String token) {
        try {
            Jwts.parserBuilder().setSigningKey(jwtSecret).build().parseClaimsJws(token);
            return true; // Se la verifica passa, il token è OK
        } catch (Exception e) {
            return false; // Se c'è un errore (scaduto, firma falsa), il token è carta straccia
        }
    }
}