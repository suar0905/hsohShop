package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Member;

public class MemberDAO {
    
    /* 비회원 - 회원가입
     * param: memb
     * return : int
     */
    public int insertMember(Member memb) throws ClassNotFoundException, SQLException {
        int successValue = 0;

        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "INSERT INTO MEMBER(MEMB_ID, MEMB_PW, MEMB_NAME, MEMB_AGE, MEMB_SEX, MEMB_LEVEL, INSERT_DATE, MODIFY_DATE, INSERT_ID, MODIFY_ID) VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW(),?,?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString (1, memb.getMembId());
        stmt.setString (2, memb.getMembPw());
        stmt.setString (3, memb.getMembName());
        stmt.setInt    (4, memb.getMembAge());
        stmt.setString (5, memb.getMembSex());
        stmt.setInt    (6, memb.getMembLevel());
        stmt.setString (7, memb.getMembId());
        stmt.setString (8, memb.getMembId());

        // 쿼리 실행
        int insertRs = stmt.executeUpdate();
        if (insertRs != 0) {
            System.out.println("[debug] 회원 추가 성공 -> " + insertRs);
            successValue = 1;
        } else {
            System.out.println("[debug] 회원 추가 실패 -> " + insertRs);
        }
        
        // 기록 종료
        stmt.close();
        conn.close();

        return successValue;
    }
	
    /* 비회원 - 로그인
     * param: member
     * return : Member
     */
    public Member login(Member member) throws ClassNotFoundException, SQLException {
        Member memb = null;

        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "SELECT A.MEMB_NO AS membNo, A.MEMB_ID AS membId, A.MEMB_PW AS membPw, A.MEMB_NAME AS membName, A.MEMB_AGE AS membAge, A.MEMB_SEX AS membSex, A.MEMB_LEVEL AS membLevel, A.INSERT_DATE AS insertDate, A.MODIFY_DATE AS modifyDate, A.INSERT_ID AS insertId, A.MODIFY_ID AS modifyId "
                + "FROM MEMBER A WHERE A.MEMB_ID=? AND A.MEMB_PW=PASSWORD(?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, member.getMembId());
        stmt.setString(2, member.getMembPw());

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            // return memb 객체 생성
            memb = new Member();
            
            memb.setMembNo    (rs.getInt("membNo"));
            memb.setMembId    (rs.getString("membId"));
            memb.setMembPw    (rs.getString("membPw"));
            memb.setMembName  (rs.getString("membName"));
            memb.setMembAge   (rs.getInt("membAge"));
            memb.setMembSex   (rs.getString("membSex"));
            memb.setMembLevel (rs.getInt("membLevel"));
            
            System.out.println("[debug] 로그인 성공 -> " + memb);
		}
		
        // 기록 종료
        rs.close();
        stmt.close();
        conn.close();
        
		return memb;
	}

    /* 비회원 - 회원가입시 회원ID 중복체크
     * param: membDupliIdCheck
     * return : int
     */
    public int selectMembDupliIdCheck(String membDupliIdCheck) throws ClassNotFoundException, SQLException {
        int successValue = 0;

        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "SELECT MEMB_ID AS membId FROM MEMBER WHERE MEMB_ID=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString (1, membDupliIdCheck);

        ResultSet rs = stmt.executeQuery();
        
        String membId = "";
        
        // 쿼리 실행
        if (rs.next()) {
            membId = rs.getString("membId");
        }
        
        if (!"".equals(membId)) {
            // 회원ID 중복
            successValue = 1;
        }
        
        // 기록 종료
        rs.close();
        stmt.close();
        conn.close();

        return successValue;
    }

    /* 회원/관리자 - 내 정보 상세보기
     * param: membNo
     * return : ArrayList<Member>
     */
    public ArrayList<Member> selectMemberOne(int membNo) throws ClassNotFoundException, SQLException {
        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "SELECT A.MEMB_NO AS membNo, A.MEMB_ID AS membId, A.MEMB_PW AS membPw, A.MEMB_NAME AS membName, A.MEMB_AGE AS membAge, A.MEMB_SEX AS membSex, A.MEMB_LEVEL AS membLevel, A.INSERT_DATE AS insertDate, A.MODIFY_DATE AS modifyDate, A.INSERT_ID AS insertId, A.MODIFY_ID AS modifyId "
                + "FROM MEMBER A WHERE A.MEMB_NO=? ORDER BY A.INSERT_DATE DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt (1, membNo);

        ResultSet rs = stmt.executeQuery();
        
        // Member 객체를 지닌 리스트 생성
     	ArrayList<Member> membList = new ArrayList<Member>();
        
        while (rs.next()) {
        	Member memb = new Member();
        	memb.setMembNo		(rs.getInt("membNo"));
        	memb.setMembId		(rs.getString("membId"));
        	memb.setMembPw		(rs.getString("membPw"));
        	memb.setMembName	(rs.getString("membName"));
        	memb.setMembLevel	(rs.getInt("membLevel"));
        	memb.setMembAge		(rs.getInt("membAge"));
        	memb.setMembSex		(rs.getString("membSex"));
        	memb.setInsertId	(rs.getString("insertId"));
        	memb.setInsertDate	(rs.getTimestamp("insertDate"));
        	memb.setModifyId	(rs.getString("modifyId"));
        	memb.setModifyDate	(rs.getTimestamp("modifyDate"));
        	
        	membList.add(memb);
        }
        
        // 기록 종료
        rs.close();
        stmt.close();
        conn.close();

        return membList;
    }
}
