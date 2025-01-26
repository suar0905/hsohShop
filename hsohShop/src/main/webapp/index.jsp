<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hsohShop 메인페이지</title>
</head>
<body>
    <%
        Member loginMemb = (Member)session.getAttribute("loginMember");
        
        // 비회원 공통 상단 메뉴
        if (loginMemb == null) {
    %>
            <div>
                <jsp:include page="/partial/subMenu.jsp"></jsp:include>
            </div>
    <%
        // 일반회원 공통 상단 메뉴
        } else if (loginMemb != null && loginMemb.getMembLevel() < 1) {
    %>
            <div>
                <jsp:include page="/partial/mainMenu.jsp"></jsp:include>
            </div>
    <%
    	// 관리자 공통 상단 메뉴
        } else if (loginMemb != null && loginMemb.getMembLevel() > 0) {
    %>
    		<div>
                <jsp:include page="/partial/adminMenu.jsp"></jsp:include>
            </div>
    <%    	
        }
    %>
    
    
    
	
	<h1>메인 페이지</h1>

	<div>
		<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
		<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	</div>
	
</body>
</html>