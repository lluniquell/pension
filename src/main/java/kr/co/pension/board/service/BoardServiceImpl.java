package kr.co.pension.board.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("bs")
public class BoardServiceImpl implements BoardService {

	@Override
	public String list() {
		// TODO Auto-generated method stub
		return "/board/list";
	}

}
