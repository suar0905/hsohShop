<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
    //한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

	String membNo = request.getParameter("membNo");
	String membPw = request.getParameter("membPw");

    // 유효성 검사(null) 및 공백 검사
    if((membNo == null || "".equals(membNo)) || (membPw == null || "".equals(membPw))) {
        response.sendRedirect(request.getContextPath() + "/selectMemberInfo.jsp");
        return;
    }
    
    Member memb = null;
    MemberDAO membDao = null;
    
    memb = new Member();
    memb.setMembNo(Integer.parseInt(membNo));
    memb.setMembPw(membPw);
    
    membDao = new MemberDAO();
    int checkResult = membDao.selectMembPwCheck(memb);
    
    if (checkResult > 0) {
        // 현재 비밀번호 일치
        response.sendRedirect(request.getContextPath() + "/popup/pwUpdatePop.jsp?pwChcek=" + membPw);
    } else {
        // 현재 비밀번호 불일치
        response.sendRedirect(request.getContextPath() + "/popup/pwUpdatePop.jsp?pwChcek=FAIL");
    }
%>