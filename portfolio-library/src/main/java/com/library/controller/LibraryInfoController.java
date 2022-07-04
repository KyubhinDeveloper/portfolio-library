package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/libraryInfo/*")
public class LibraryInfoController {
	
	@GetMapping("/location")
	public void location() {
		
	}
	
	@GetMapping("/summary")
	public void summary() {
		
	}
}