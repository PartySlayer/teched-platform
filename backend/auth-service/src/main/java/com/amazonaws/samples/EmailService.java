package com.amazonaws.samples;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import software.amazon.awssdk.services.ses.SesClient;
import software.amazon.awssdk.services.ses.model.*;

@Service
public class EmailService {

    private final SesClient sesClient;
    
    @Value("${aws.ses.from-email:sender@example.com}")
    private String fromEmail;
    
    @Value("${aws.ses.configuration-set:}")
    private String configurationSet;

    public EmailService(SesClient sesClient) {
        this.sesClient = sesClient;
    }

    public void sendEmail(String to, String subject, String htmlBody, String textBody) {
        try {
            SendEmailRequest.Builder requestBuilder = SendEmailRequest.builder()
                    .source(fromEmail)
                    .destination(Destination.builder().toAddresses(to).build())
                    .message(Message.builder()
                            .subject(Content.builder().data(subject).build())
                            .body(Body.builder()
                                    .html(Content.builder().data(htmlBody).build())
                                    .text(Content.builder().data(textBody).build())
                                    .build())
                            .build());
            
            if (!configurationSet.isEmpty()) {
                requestBuilder.configurationSetName(configurationSet);
            }
            
            sesClient.sendEmail(requestBuilder.build());
        } catch (SesException e) {
            throw new RuntimeException("Failed to send email", e);
        }
    }
}