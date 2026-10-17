package com.rahulchauhan.devfolio.common;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;

@RestController
@RequestMapping("/api/v1/ping")
public class PingController {

    @GetMapping
    public PingResponse ping() {
        return new PingResponse("Welcome to my devfolio", Instant.now());
    }

    public record PingResponse(String message, Instant timestamp) {
    }
}
