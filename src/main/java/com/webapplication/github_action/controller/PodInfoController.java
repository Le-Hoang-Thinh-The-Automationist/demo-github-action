package com.webapplication.github_action.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PodInfoController {

    @GetMapping("/pod-id")
    public String getPodId(){
        // La variable d'environnement "HOSTNAME" contient l’ID du pod dans Kubernetes.
        return System.getenv("HOSTNAME");
    }
}