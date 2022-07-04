package com.library;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
@MapperScan("com.library.mapper")
public class PortfolioLibraryApplication {

	public static void main(String[] args) {
		SpringApplication.run(PortfolioLibraryApplication.class, args);
	}
}