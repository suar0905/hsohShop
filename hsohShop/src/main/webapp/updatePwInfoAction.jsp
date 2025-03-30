<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
    //한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

	String membNo = request.getParameter("membNoCheck");
	String membPwOrg = request.getParameter("membPwOrg");
	String newMembPw = request.getParameter("newMembPw");;
	
    // 유효성 검사(null) 및 공백 검사
    if((membNo == null || "".equals(membNo)) || (membPwOrg == null || "".equals(membPwOrg))
    		|| (newMembPw == null || "".equals(newMembPw))) {
        response.sendRedirect(request.getContextPath() + "/selectMemberInfo.jsp");
        return;
    }
    
    MemberVO memb = null;
    MemberDAO membDao = null;
    
    memb = new MemberVO();
    memb.setMembNo(Integer.parseInt(membNo));
    memb.setMembPw(membPwOrg);
    memb.setNewMembPw(newMembPw);
    
    membDao = new MemberDAO();
    int result = membDao.updatePwInfo(memb);
    
    if (result > 0) {
        // 성공
        // session.invalidate(); // 세션 종료
        response.sendRedirect(request.getContextPath() + "/popup/pwUpdatePop.jsp?successPw=PASS");
    } else {
        // 실패
        out.println("<script>alert('비밀번호 수정 실패');</script>");
        response.sendRedirect(request.getContextPath() + "/popup/pwUpdatePop.jsp?pwChcek=FAIL");
    }
%>