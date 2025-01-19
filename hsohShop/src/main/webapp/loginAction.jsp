<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>

<%
    //한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

    // 인증 방어 코드 
    // 로그인 전(session.getAttribute("loginMember") -> null)에만 페이지 열람 가능하다.
    if (session.getAttribute("loginMember") != null) {
        System.out.println("[debug] 이미 로그인 되어 있습니다.");
        
        // 상대주소 표기
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }

    // loginForm.jsp 파라미터 가져옴
    String membId = request.getParameter("membId");
    String membPw = request.getParameter("membPw");
    
    System.out.println("회원id" + membId);
    System.out.println("회원pw" + membPw);
    
    // DAO에 사용될 파라미터 객체 생성
    Member paramMemb = new Member();
    paramMemb.setMembId(membId);
    paramMemb.setMembPw(membPw);
    
    MemberDAO membDAO = new MemberDAO();
    
    // 회원 loign 정보 가져옴
    Member returnMemb = membDAO.login(paramMemb);
    
    if (returnMemb == null) {
        System.out.println("로그인 실패!!!");
        response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
        return;
    } else {
        System.out.println("로그인 성공!!!");
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        // 세션에 로그인 정보 저장
        session.setAttribute("loginMember", returnMemb);
    }
    
%>
