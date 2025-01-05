package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.Member;

public class MemberDAO {
    
    /* 회원가입 - 회원추가 [비회원]
     * input: Member
     * output : int
     */
    public int insertMember(Member member) throws ClassNotFoundException, SQLException {
        int successValue = 0;

        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "INSERT INTO member(memb_id, memb_pw, memb_name, memb_age, memb_sex, memb_level, insert_date, modify_date, insert_id, modify_id) VALUES(?,PASSWORD(?),?,?,?,?,NOW(),NOW(),?,?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString (1, member.getMembId());
        stmt.setString (2, member.getMembPw());
        stmt.setString (3, member.getMembName());
        stmt.setInt    (4, member.getMembAge());
        stmt.setString (5, member.getMembSex());
        stmt.setInt    (6, member.getMembLevel());
        stmt.setString (7, member.getInsertId());
        stmt.setString (8, member.getModifyId());

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
	
    /* 회원가입 - 로그인
     * input: Member
     * output : Member
     */
    public Member login(Member member) throws ClassNotFoundException, SQLException {
        Member memb = null;

        // maria db를 사용 및 접속하기 위해 commons 패키지의 DBUtil클래스 사용
        DBUtil dbUtil = new DBUtil();
        Connection conn = dbUtil.getConnection();

        // 쿼리문 생성
        String sql = "SELECT A.MEMB_NO AS membNo, A.MEMB_ID AS membId, A.MEMB_PW AS membPw, A.MEMB_NAME AS membName, A.MEMB_AGE AS membAge, A.MEMB_SEX AS membSex, A.MEMB_LEVEL AS membLevel, A.INSERT_DATE AS insertDate, A.MODIFY_DATE AS modifyDate, A.INSERT_ID AS insertId, A.MODIFY_ID AS modifyId "
                + "FROM MEMBER WHERE A.MEMB_ID=? AND A.MEMB_PW=?";
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

}
