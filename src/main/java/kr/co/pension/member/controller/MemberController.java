package kr.co.pension.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.member.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	@Qualifier("ms")
	private MemberService service;
	
	@RequestMapping("/join")
	public String join() {
		return service.join();
	}
}
