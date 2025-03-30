<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

	// 로그인 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

    // (1) MemberDao 클래스 객체 생성
	MemberDAO memberDao = new MemberDAO();
	
	// (2) Member 클래스 배열 객체 변수 생성(selectMemberOne 메소드 이용)
	ArrayList<Member> membList = memberDao.selectMemberOne((int)loginMember.getMembNo());
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>내 정보</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>

<body>

	<%
        // 비회원 공통 상단 메뉴
        if (loginMember != null && loginMember.getMembLevel() < 1) {
    %>
            <div>
                <jsp:include page="/partial/mainMenu.jsp"></jsp:include>
            </div>
    <%
    	// 관리자 공통 상단 메뉴
        } else if (loginMember != null && loginMember.getMembLevel() > 0) {
    %>
    		<div>
                <jsp:include page="/partial/adminMenu.jsp"></jsp:include>
            </div>
    <%    	
        }
    %>

	<div class="container"> 
		<h2 style="text-align:center; margin: 3% 0 1% 0;">
			<%
			if (loginMember.getMembLevel() == 0) {
			%>
					[회원정보]
			<%		
				} else if (loginMember.getMembLevel() == 1) {
			%>
					[관리자정보]
			<%		
				}
			%>
		</h2>
		<table class="table table-secondary table-bordered" style="text-align:center;" border="1">
			<%
				for (Member m : membList) {
		    %>
		    		<form name="pwForm" method="post">
		    			<input type="hidden" name="membNo" value="<%=m.getMembNo()%>" readonly="readonly">
		    		</form>
		    <%
					// 일반회원
					if (m.getMembLevel() == 0) {
						
			%>
					<tr>
						<th>회원아이디</th>
						<td><%=m.getMembId()%></td>
					</tr>
					<tr>
						<th>회원등급</th>
						<td>
							<%
								// 0:일반회원, 1:관리자
								if (m.getMembLevel() == 0) {
							%>
									일반회원
							<%		
								} else if (m.getMembLevel() == 1) {
							%>
									관리자
							<%
								}
							%>
						</td>
					</tr>
					<tr>
						<th>회원이름</th>
						<td><%=m.getMembName()%></td>
					</tr>
					<tr>
						<th>회원나이</th>
						<td><%=m.getMembAge()%></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><%=m.getMembSex()%></td>
					</tr>
					<tr>
						<th>가입아이디</th>
						<td><%=m.getInsertId()%></td>
					</tr>
					<tr>
						<th>가입날짜</th>
						<td><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="<%=m.getInsertDate()%>"/></td>
					</tr>
					<tr>
						<th>수정아이디</th>
						<td><%=m.getModifyId()%></td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="<%=m.getModifyDate()%>"/></td>
					</tr>
			<%
					} else if (m.getMembLevel() == 1) { // 관리자
			%>
					<tr>
						<th>관리자아이디</th>
						<td><%=m.getMembId()%></td>
					</tr>
					<tr>
						<th>회원등급</th>
						<td>
							<%
								// 0:일반회원, 1:관리자
								if (m.getMembLevel() == 0) {
							%>
									일반회원
							<%		
								} else if (m.getMembLevel() == 1) {
							%>
									관리자
							<%
								}
							%>
						</td>
					</tr>
					<tr>
						<th>관리자이름</th>
						<td><%=m.getMembName()%></td>
					</tr>
					<tr>
						<th>관리자나이</th>
						<td><%=m.getMembAge()%></td>
					</tr>
					<tr>
						<th>성별</th>
						<td><%=m.getMembSex()%></td>
					</tr>
					<tr>
						<th>가입아이디</th>
						<td><%=m.getInsertId()%></td>
					</tr>
					<tr>
						<th>가입날짜</th>
						<td><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="<%=m.getInsertDate()%>"/></td>
					</tr>
					<tr>
						<th>수정아이디</th>
						<td><%=m.getModifyId()%></td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td><fmt:formatDate pattern="yyyy/MM/dd hh:mm:ss" value="<%=m.getModifyDate()%>"/></td>
					</tr>
			<%
					}
				}
			%>
		</table>
		
		<div style="text-align:center; margin: 1% 0 0 0;">
			<button id="pwBtnPop" class="btn btn-outline-danger">비밀번호 수정</button>
			<a class="btn btn-outline-danger" href="<%=request.getContextPath()%>/deleteMemberInfoForm.jsp?memberNo=<%=loginMember.getMembNo()%>&memberName=<%=loginMember.getMembName()%>">회원탈퇴</a>
		</div>
	</div>

</body>

<script>
	var pwBtnPop = document.getElementById('pwBtnPop');
	var popAddr = '/popup/pwUpdatePop.jsp';
	var popName = '비밀번호 변경 팝업';
	
	pwBtnPop.addEventListener('click', () => {
	    window.open(popAddr, popName, 'width=450, height=250, top=150, left=200');
	    document.pwForm.membNo.value;
	});
	
</script>

</html>