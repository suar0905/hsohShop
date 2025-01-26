<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 기존 세션 삭제 후 새로운 세션으로 갱신
	session.invalidate();

	// 로그아웃 후 메인화면으로 넘김
	response.sendRedirect(request.getContextPath() + "/index.jsp");
%>