<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>

<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

    // 인증 방어 코드 
    if(session.getAttribute("loginMember") != null){
        System.out.println("[debug] 이미 로그인 되어 있습니다.");
        
        // 상대주소 표기
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    // insertMemberForm에서 변수값 가져오기
    String membId   = request.getParameter("membId");
    String membPw   = request.getParameter("membPw");
    int membLevel   = Integer.parseInt(request.getParameter("membLevel"));
    String membName = request.getParameter("membName");
    int membAge     = Integer.parseInt(request.getParameter("membAge"));
    String membSex  = request.getParameter("membSex");
    
    // member라는 변수에 입력받은 값들 저장하기.
    Member memb = new Member();
    
    memb.setMembId(membId);
    memb.setMembPw(membPw);
    memb.setMembLevel(membLevel);
    memb.setMembName(membName);
    memb.setMembAge(membAge);
    memb.setMembSex(membSex);
    memb.setInsertId(membId);
    memb.setModifyId(membId);
    
    MemberDAO memberDao = new MemberDAO();
    int insertRs = memberDao.insertMember(memb);
    
    if(insertRs == 1){
        // 가입 성공
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    } else{ 
        // 가입 실패
        response.sendRedirect(request.getContextPath() + "/insertMemberForm.jsp");
    }
%>