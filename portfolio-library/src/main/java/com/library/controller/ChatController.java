package com.library.controller;



import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.java.Log;

@Log
@Controller
@RequestMapping("/chat/*")
public class ChatController {

	@GetMapping("/chatPage")
	public String chatPage(HttpSession session) {
		
		String id = (String)session.getAttribute("id");
		
		if(id == null) {
			return "redirect:/member/login";
		} else {
			return "/chat/chatPage";
		}
	} //chatPage()
	
	@GetMapping("/exampleChat")
	public void exampleChat() {
		
	} //chatPage()
	
	@GetMapping("/exampleChat2")
	public void exampleChat2() {
		
	} //chatPage()
}