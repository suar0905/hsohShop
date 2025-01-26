<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<!--  관리자 공통 상단 메뉴 -->
<div class="container-fluid">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="col-sm-10">
			<ul class="navbar-nav">
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">[홈으로]</a>
				</li>
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/selectNoticeOne.jsp">[공지사항게시판]</a>
				</li>
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/selectQnaList.jsp">[QnA게시판]</a>
				</li>
			</ul>
		</div>
		
		<div class="col-sm-2">
			<%
				// Member 클래스 변수 생성(로그인 기록정보 저장)
				Member loginMember = (Member)session.getAttribute("loginMember");
			
				// 로그인 전(session 영역안에 null값이면)
				if (session.getAttribute("loginMember") == null) {
			%>
				<div class="row row-2">
					<a class="btn btn-light" href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a>&ensp;
					<a class="btn btn-light" href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a>
				</div>
			<% 
				// 로그인 후(session 영역안에 값이 있으면)
				} else if (loginMember.getMembLevel() == 1) {
			%>
				<div class="dropdown">
					<button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown">
				    	<%=loginMember.getMembName()%>님
				  	</button>
				  
				  	<ul class="dropdown-menu" style="text-align:center;">
				    	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/logoutAction.jsp">로그아웃</a></li>
				    	<li><a class="dropdown-item" href="<%=request.getContextPath()%>/selectMemberInfo.jsp">내 정보</a></li>
				  	</ul>
				</div>
			<% 		
				}
			%>
		</div>
	</nav>
</div>