package com.webapplication.github_action.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PodInfoController {
        
    @GetMapping("/")
    public String getWelcomeMessage() {
        // Retrieves the HOSTNAME environment variable
        String hostname = System.getenv("HOSTNAME"); 

        return "Hello world, welcome to " + hostname;
    }

}