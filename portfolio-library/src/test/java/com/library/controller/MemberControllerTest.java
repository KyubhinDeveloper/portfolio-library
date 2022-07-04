package com.library.controller;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.web.WebAppConfiguration;

import lombok.extern.java.Log;


@Log
@WebAppConfiguration
@SpringBootTest
public class MemberControllerTest {
	
	@Autowired
	MemberController memberController;
	

	@Test
	public void memberTest() throws Exception {
		
		log.info(memberController.getClass().getName());
	}
	
}