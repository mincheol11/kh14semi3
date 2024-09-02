package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.mapper.MemberMapper;
import com.kh.kh14semi3.mapper.MemberTakeOffMapper;
import com.kh.kh14semi3.vo.MemberTakeOffVO;
import com.kh.kh14semi3.vo.PageVO;

@Service
public class MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private MemberTakeOffMapper memberTakeOffMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private PasswordEncoder encoder;

	//회원 상세
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data  = {memberId};
		List<MemberDto>list = jdbcTemplate.query(sql,memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	//로그인전용 상세조회(암호화비번때문에)
	public MemberDto selectOneWithPassword(String memberId, String memberPw) {
		String sql = "select * from member where member_id = ?";
		Object[] data  = {memberId};
		List<MemberDto>list = jdbcTemplate.query(sql,memberMapper, data);
		if(list.isEmpty()) return null;
		
		MemberDto memberDto = list.get(0); //비밀번호 비교
		boolean isValid = encoder.matches(memberPw, memberDto.getMemberPw());
		//ture, false가 나온다
		return isValid ? memberDto : null;
		
	}
	
//	회원 최종 로그인 시각 갱신 필요시 주석 해제
//	public boolean updateMemberLogin(String memberId) {
//		String sql = "update member set member_login=sysdate "
//						+ "where member_id = ?";
//		Object[] data = {memberId};
//		return jdbcTemplate.update(sql, data) > 0;
//	}
	
	//페이징 관련 메소드
	public List<MemberTakeOffVO> selectListByPaging(PageVO pageVO) {
        if(pageVO.isSearch()) { // 검색
            String sql = "select * from ("
                    + "select rownum rn, TMP.* from ("
                    + "select "
                    + "M.*, T.takeOff_no, T.takeOff_memo, T.takeOff_time, "
                    + "T.takeOff_target, nvl(T.takeOff_type, '재학') takeOff_type "
                    + "from member M "
                    + "left outer join takeOff_latest T "
                    + "on M.member_id = T.takeOff_target "
                    + "where instr("+pageVO.getColumn()+", ?) >0 "
                    + "order by "+pageVO.getColumn()+" asc, M.member_id asc"
                    + ") TMP"
                    + ") where rn between ? and ?";
                    Object[] data = {pageVO.getKeyword(), 
                        pageVO.getBeginRow(), pageVO.getEndRow()};
                    return jdbcTemplate.query(sql, memberTakeOffMapper, data);
        }
        else { // 목록
            String sql = "select * from ("
                    + "select rownum rn, TMP.* from ("
                    + "select "
                    + "M.*, T.takeOff_no, T.takeOff_memo, T.takeOff_time, "
                    + "T.takeOff_target, nvl(T.takeOff_type, '재학') takeOff_type "
                    + "from member M "
                    + "left outer join takeOff_latest T "
                    + "on M.member_id = T.takeOff_target "
                    + "order by M.member_id asc"
                    + ") TMP"
                    + ") where rn between ? and ?";
                    Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
                    return jdbcTemplate.query(sql, memberTakeOffMapper, data);
        }
    }

	public int countWithPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql = "select count(*) from member where instr("+pageVO.getColumn()+", ?) > 0";
			Object[] data = {pageVO.getKeyword()}; 
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {
			String sql = "select count(*) from member";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public boolean delete(String memberId) {
		String sql = "delete from member where member_id=?";
		Object[] data = {memberId};
		return jdbcTemplate.update(sql, data) >0;
	}

	public void insert(MemberDto memberDto) {
		//비밀번호 암호화
		String rawPw = memberDto.getMemberPw(); // 비밀번호 암호화안된것
		String encPw = encoder.encode(rawPw); // 암호화된 비밀번호
		memberDto.setMemberPw(encPw);
		
		String sql = "insert into member("
				+ "member_id, member_pw, member_name, member_rank, "
				+ "member_email, member_cell, member_birth, member_post, "
				+ "member_address1, member_address2 "
				+ ") "
				+ "values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
			memberDto.getMemberId(), memberDto.getMemberPw(), memberDto.getMemberName(),
			memberDto.getMemberRank(), memberDto.getMemberEmail(), memberDto.getMemberCell(),
			memberDto.getMemberBirth(), memberDto.getMemberPost(), memberDto.getMemberAddress1(),
			memberDto.getMemberAddress2()
		};
		jdbcTemplate.update(sql, data);
	}

	// 비밀번호 변경
		public boolean updateMemberPw(String memberId, String memberPw) {
			//비밀번호 암호화
			String rawPw = memberPw; // 비밀번호 암호화안된것
			String encPw = encoder.encode(rawPw); // 암호화된 비밀번호
			
			String sql = "update member set member_pw=? where member_id=?";
			Object[] data = { encPw, memberId };
			return jdbcTemplate.update(sql, data) > 0;
		}
		
	public boolean updateMemberByAdmin(MemberDto memberDto) {
		String sql = "update member set "
				+ "member_name=?, member_rank=?, "
				+ "member_email=?, member_cell=?, "
				+ "member_birth=?, member_post=?, "
				+ "member_address1=?, member_address2=? "
				+ "where member_id=? ";
		Object[] data = {
			memberDto.getMemberName(), memberDto.getMemberRank(),
			memberDto.getMemberEmail(), memberDto.getMemberCell(),
			memberDto.getMemberBirth(), memberDto.getMemberPost(),
			memberDto.getMemberAddress1(), memberDto.getMemberAddress2(),
			memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data)>0;
	}
	
	public boolean update(MemberDto memberDto) {
		//비밀번호 암호화
		String rawPw = memberDto.getMemberPw(); // 비밀번호 암호화안된것
		String encPw = encoder.encode(rawPw); // 암호화된 비밀번호
		memberDto.setMemberPw(encPw);
		
		String sql = "update member set "
				+ "member_name=?, member_rank=?, "
				+ "member_pw=?, "
				+ "member_email=?, member_cell=?, "
				+ "member_birth=?, member_post=?, "
				+ "member_address1=?, member_address2=? "
				+ "where member_id=? ";
		Object[] data = {
			memberDto.getMemberName(), memberDto.getMemberRank(),
			memberDto.getMemberPw(),
			memberDto.getMemberEmail(), memberDto.getMemberCell(),
			memberDto.getMemberBirth(), memberDto.getMemberPost(),
			memberDto.getMemberAddress1(), memberDto.getMemberAddress2(),
			memberDto.getMemberId()
		};
		return jdbcTemplate.update(sql, data)>0;
	}

}		
		


