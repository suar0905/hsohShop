<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

    // 인증 방어코드(로그인 전에만 열람 가능할 수 있도록)
    Member loginMember = (Member)session.getAttribute("loginMember");
    if (loginMember != null) {
        System.out.println("[debug] 이미 로그인 되어있습니다.");
        
        // 상대주소 표기
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
    <!-- 페이지 상단 메인메뉴 세팅 -->
    <div>
        <jsp:include page="/partial/subMenu.jsp"></jsp:include>
    </div>
    
    
    <div class="container-sm text-center">
	    <h1>* 로그인 페이지 *</h1>
    	<div class="jumbotron">
		    <form id="loginForm" action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
		        <div class="form-floating mb-3">
		        	<input type="text" class="form-control" name="membId" id="membId" placeholder="ID">
  					<label for="floatingInput">회원 아이디</label>
		        </div>
		        
		        <div class="form-floating">
		        	<input type="text" class="form-control" name="membPw" id="membPw" placeholder="Password">
  					<label for="floatingPassword">회원 비밀번호</label>
		        </div>
		        
		        <br>
		        
		        <div>
		            <input type="button" name="loginBtn" id="loginBtn" value="로그인" class="btn btn-outline-secondary">
		            <input type="reset" value="초기화" class="btn btn-outline-danger">
		            <input type="button" value="뒤로가기" onclick="history.back();" class="btn btn-outline-secondary">
		        </div>
		    </form>
	    </div>
    </div>
    
    
    <script>
        $('#loginBtn').click(function() {
            if ($('#membId').val() == '') {
                alert('회원ID를 입력해주세요.');
                return false;
            } else if ($('#membPw').val() == '') {
                alert('회원PW를 입력해주세요.');
                return false;
            } else {
                // 로그인 진행
                $('#loginForm').submit();
            }
        });
        
    </script>
</body>
</html>