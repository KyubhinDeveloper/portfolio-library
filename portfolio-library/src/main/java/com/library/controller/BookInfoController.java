package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/bookInfo/*")
public class BookInfoController {
	
	@GetMapping("/bookApply")
	public void bookApply() {
		
	}
	
	@GetMapping("/returnOfLoan")
	public void returnOfLoan() {
		
	}
	
	
}