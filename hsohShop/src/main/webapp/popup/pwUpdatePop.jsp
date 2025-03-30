<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>

<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

	// 로그인 정보 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if (loginMember == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	
    // membPwCheck : 현재 비밀번호 체크 값
    String membPwCheck = "";
    if (request.getParameter("pwChcek") != null) {
    	membPwCheck = request.getParameter("pwChcek");
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 팝업</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	
	<div class="container-sm text-center">
        <div class="jumbotron">
            <!-- 현재 비밀번호 Check -->
            <form id="pwForm" action="<%=request.getContextPath()%>/pwCheckAction.jsp" method="post">
                <table class="table table-borderless table-responsive-sm">
                    <tr>
                        <th><input type="text" class="form-control" name="membPw" id="membPw" placeholder="ENTER PW"></th>
                        <td><button id="pwChcekBtn" class="btn btn-outline-danger">현재 비밀번호 체크</button></td>
                        <input type="hidden" id="membPwCheck" value="<%=request.getParameter("pwChcek")%>">
                        <input type="hidden" name="membNo" id="membNo">
                    </tr>
                </table>
            </form>
            
            <!-- 신규 비밀번호 생성 -->
            <form id="newPwForm" action="<%=request.getContextPath()%>/updatePwInfoAction.jsp" method="post">
                <table class="table table-borderless table-responsive-sm">
                    <tr>
                        <th><input type="text" class="form-control" name="newMembPw" id="newMembPw" placeholder="ENTER NEW PW"></th>
                        <td><button id="newPwBtn" class="btn btn-outline-danger">신규 비밀번호 입력</button></td>
                        <input type="hidden" name="membPwOrg" id="membPwOrg">
                        <input type="hidden" name="membNoCheck" id="membNoCheck">
                    </tr>
                </table>
            </form>
            
            <input type="hidden" name="successPw" id="successPw" value="<%=request.getParameter("successPw")%>">
        </div>  
    </div>

	<script>
	    // 페이지 로드시 
	    $(document).ready(function() {
	        if ($('#membPwCheck').val() != 'null') {
	            if ($('#membPwCheck').val() == 'FAIL') {
	            	// 현재 비밀번호 체크 실패
	                alert('현재 사용중인 비밀번호가 아닙니다.');
	                $('#newPwForm').hide();
	                return false;
	            } else {
	            	// 현재 비밀번호 체크 성공
	                alert('새로운 비밀번호를 입력해주세요.');
	                $('#membPwOrg').attr('value', $('#membPwCheck').val());
	                $('#membNoCheck').attr('value', $('#membNo').val());
	                $('#pwForm').hide();
	                $('#newPwForm').show();
	                return;
	            }
	        } else if($('#successPw').val() == 'PASS') {
	        	// 비밀번호 수정 성공
                alert('비밀번호가 수정되었습니다. 다시 로그인 해주세요.');
                self.close(); // 팝업창 종료
                opener.location.replace("http://localhost/logoutAction.jsp");
	        } else {
	            $('#newPwForm').hide();
	        }
	    });
	
		// 부모창에서 membNo값 가져오기
		var membNo = opener.document.pwForm.membNo.value;
		
		// 자식(팝업)창 membNo값 세팅
		document.getElementById('membNo').value = membNo;
		
        // 현재 비밀번호 유효성체크
        $('#pwChcekBtn').click(function() {
            if ($('#membPw').val() == '') {
            	alert('현재 비밀번호를 입력해주세요.');
                return false;
            } 
            
            $('#pwForm').submit();
        });
        
        // 신규 비밀번호 입력
        $('#newPwBtn').click(function() {
            if ($('#newMembPw').val() == '') {
            	alert('신규 비밀번호를 입력해주세요.');
                return false;
            } 
            
            $('#newPwForm').submit();
        });
	</script>
	
</body>
</html>