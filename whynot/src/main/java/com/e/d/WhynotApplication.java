package com.e.d;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class WhynotApplication {
	

	public static void main(String[] args) {
		SpringApplication.run(WhynotApplication.class, args);
	}

}
