<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<!--  비회원 공통 상단 메뉴 -->
<div class="container-fluid">
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="col-sm-10">
			<ul class="navbar-nav">
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/index.jsp">[홈으로]</a>
				</li>
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/loginForm.jsp">[로그인]</a>
				</li>
				<li class="nav-item active">
					<a class="navbar-brand" href="<%=request.getContextPath()%>/insertMemberForm.jsp">[회원가입]</a>
				</li>
			</ul>
		</div>
		
		
	</nav>
</div>