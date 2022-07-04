package com.library.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/facilityInfo/*")
public class FacilityInfoController {
	
	@GetMapping("/openHour")
	public void openHour() {
		
	}
	
	@GetMapping("/memberInfo")
	public void memberInfo() {
		
	}
	
	@GetMapping("/readingRoom")
	public void readingRoom() {
		
	}
	
	@GetMapping("/roomStatus")
	public void roomStatus() {
		
	}
}