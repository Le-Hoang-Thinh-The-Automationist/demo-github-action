package com.webapplication.github_action.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class DbHealthController {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public DbHealthController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/check")
    public ResponseEntity<String> checkDatabaseConnection() {
        try {
            // issue a trivial query – faster and lighter than opening a raw Connection
            jdbcTemplate.execute("SELECT 1");
            return ResponseEntity.ok("Database is UP");
        } 
        catch (DataAccessException e) {
            // any failure here means DB is unreachable or mis-configured
            return ResponseEntity.status(HttpStatus.SERVICE_UNAVAILABLE)
                                 .body("Database is DOWN: " + e.getMessage());
        }
    }
}
