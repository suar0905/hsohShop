<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>

<%
    //한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

    // 유효성 검사(null) 및 공백 검사
    if(request.getParameter("membDupliIdCheck") == null || "".equals(request.getParameter("membDupliIdCheck"))) {
        System.out.println("[debug] memberIdCheck의 값이 Null 이거나 공백입니다.");
        
        response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
        return;
    }
    
    // insertMemberForm.jsp에서 membDupliIdCheck 값 가져옴
    String membDupliIdCheck = request.getParameter("membDupliIdCheck");
    
    MemberDAO membDao = new MemberDAO();
    int checkResult = membDao.selectMembDupliIdCheck(membDupliIdCheck);
    
    if (checkResult > 0) {
        // 회원ID 중복
        response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?membDupliIdCheck=alreadyExistsId");
    } else {
        // 회원ID 사용 가능
        response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp?membDupliIdCheck=" + membDupliIdCheck);
    }
%>
