package com.tutorlink;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
// main class - start Spring Boot application
@SpringBootApplication

public class TutorLinkApplication {
	public static void main(String[] args) {

		SpringApplication.run(TutorLinkApplication.class, args);
		System.out.println("TutorLink is running! Open: http://localhost:8080");
	}
}
