package com.example.auth_service.amazonaws;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class EmailTestRunner implements CommandLineRunner {

    private final EmailService emailService;

    public EmailTestRunner(EmailService emailService) {
        this.emailService = emailService;
    }

    @Override
    public void run(String... args) {
        String htmlBody = "<h1>Amazon SES test (Spring Boot 3)</h1>"
                + "<p>This email was sent with <a href='https://aws.amazon.com/ses/'>Amazon SES</a> "
                + "using Spring Cloud AWS</p>";
        
        String textBody = "This email was sent through Amazon SES using Spring Boot 3.";
        
        try {
            emailService.sendEmail(
                "otp@teched-platform.xyz",  // Cambia con la tua email
                "Test SES Connection",
                htmlBody,
                textBody
            );
            System.out.println("Email sent successfully!");
        } catch (Exception ex) {
            System.out.println("Failed to send email: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}