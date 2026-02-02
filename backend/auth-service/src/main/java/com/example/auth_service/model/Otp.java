package com.example.auth_service.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;

/**
 * Rappresenta la tabella degli OTP nel database.
 * Un senior dev usa nomi plurali per le tabelle (@Table) per evitare conflitti
 * con parole riservate del database (es. "User", "Order", "Group").
 */
@Entity
@Table(name = "otps")
@Getter // Lombok: genera i getter a tempo di compilazione, mantiene il file leggibile.
@Setter // Lombok: genera i setter. Fondamentale per il mapping DTO -> Entity.
@NoArgsConstructor // Requisito JPA: serve un costruttore vuoto per istanziare l'oggetto tramite Reflection.
public class Otp {

    /**
     * Chiave primaria.
     * Usiamo IDENTITY per l'autoincremento: il database assegna l'ID dopo l'insert.
     * È la scelta standard per PostgreSQL/MySQL. Non usiamo SEQUENCE perché IDENTITY
     * è più semplice da gestire in piccoli/medi microservizi.
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Il codice OTP.
     * NOTA: Usiamo String invece di int. Perché?
     * 1. Se l'OTP è "001234", un int lo salverebbe come 1234, perdendo gli zeri.
     * 2. Non dobbiamo fare calcoli matematici sull'OTP, è solo una sequenza di caratteri.
     */
    @Column(nullable = false, length = 6)
    private String otpCode;

    /**
     * Email del destinatario.
     * Indispensabile per recuperare l'OTP durante la fase di verifica.
     */
    @Column(nullable = false)
    private String email;

    /**
     * Timestamp di creazione.
     * updatable = false garantisce che, una volta scritto, il valore non cambi mai.
     * Usiamo LocalDateTime (Java 8+) perché è immutabile e gestisce meglio i fusi orari di Date.
     */
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    /**
     * Timestamp di scadenza.
     * Cruciale per la sicurezza: un OTP che non scade è una vulnerabilità critica.
     */
    @Column(nullable = false)
    private LocalDateTime expiresAt;

    /**
     * Logica di Business incapsulata nell'Entità (Rich Domain Model).
     * Permette al Service di fare un controllo rapido: if(otp.isExpired()) { ... }
     */
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(expiresAt);
    }

    /**
     * Hook del ciclo di vita JPA.
     * Viene eseguito automaticamente un istante prima che l'oggetto venga salvato nel DB.
     * Ci evita di dover settare manualmente la data di creazione nel Service.
     */
    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
    }
}