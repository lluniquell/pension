package kr.co.pension.member.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
@Qualifier("ms")
public class MemberServiceImpl implements MemberService{

	@Override
	public String join() {
		// TODO Auto-generated method stub
		return "member/join";
	}

}
