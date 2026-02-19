package com.example.auth_service.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtUtils jwtUtils;

    public JwtAuthenticationFilter(JwtUtils jwtUtils) {
        this.jwtUtils = jwtUtils;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {

        // 1. Controlla se nella busta (Request) c'è l'intestazione "Authorization"
        String authHeader = request.getHeader("Authorization");

        // Il token deve iniziare con "Bearer " (è lo standard internazionale)
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7); // Taglia la parola "Bearer " e prende solo il codice

            // 2. Chiede a JwtUtils se il codice è valido
            if (jwtUtils.validateToken(token)) {
                String email = jwtUtils.getEmailFromToken(token);

                // 3. Se è valido, crea un oggetto che dice a Spring: "Questo utente è chi dice di essere"
                UsernamePasswordAuthenticationToken authentication =
                        new UsernamePasswordAuthenticationToken(email, null, new ArrayList<>());

                // Inserisce l'utente nel "Contesto di Sicurezza".
                // Da questo momento, Spring sa che l'utente è autenticato per questa specifica richiesta.
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }
        }

        // Passa la palla al filtro successivo (o al Controller)
        filterChain.doFilter(request, response);
    }
}