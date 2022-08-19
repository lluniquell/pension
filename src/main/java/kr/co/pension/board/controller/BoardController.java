package kr.co.pension.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.pension.board.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	@Qualifier("bs")
	private BoardService service;
	
	@RequestMapping("/list")
	public String list() {
		
		return service.list();
	}
}
