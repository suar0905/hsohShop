<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // 한글 깨짐 방지
    request.setCharacterEncoding("utf-8");

    // 인증 방어코드(로그인 전에만 열람 가능할 수 있도록)
    if (session.getAttribute("loginMember") != null) {
        System.out.println("[debug] 이미 로그인 되어있습니다.");
        
        // 상대주소 표기
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
    
    // membDupliIdCheck : memberId 중복 여부 확인 변수
    String membDupliIdCheck = "";
    if(request.getParameter("membDupliIdCheck") != null) {
        membDupliIdCheck = request.getParameter("membDupliIdCheck");
    }
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>

    <div class="container-sm text-center">
        <div class="jumbotron">
    
            <h2>* 회원가입 페이지 *</h2>

            <!-- 중복ID Check -->
            <form action="<%=request.getContextPath()%>/membDupliIdCheckAction.jsp" method="post">
                <table class="table table-borderless table-responsive-sm">
                    <tr>
                        <th><input type="text" class="form-control" name="membDupliIdCheck" id="membDupliIdCheck" placeholder="ENTER ID"></th>
                        <td><input type="submit" id="membCheckBtn" value="중복아이디 체크" class="btn btn-outline-danger"></td>
                        <input type="hidden" id="membDulpliId" value="<%=request.getParameter("membDupliIdCheck")%>">
                    </tr>
                </table>
            </form>

            <form id="joinForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
                <table class="table table-border table-responsive-sm">
                    <tr>
                        <th>회원 아이디</th>
                        <td><input class="btn btn-light" type="text" id="membId" name="membId" readonly="readonly"></td>
                    </tr>
                    <tr>
                        <th>회원 비밀번호</th>
                        <td><input class="btn btn-outline-dark" type="password" id="membPw" name="membPw" placeholder="Enter Pw"></td>
                    </tr>
                    <tr>
                        <th>회원 등급</th>
                        <td>
                            <select name="membLevel" >
                                <option value="none" selected>== 선택 ==</option>
                                <option value="0">일반 회원</option>
                                <option value="1">관리자</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>회원명</th>
                        <td><input class="btn btn-outline-dark" type="text" id="membName" name="membName" placeholder="Enter Name"></td>
                    </tr>
                    <tr>
                        <th>회원 나이</th>
                        <td><input class="btn btn-outline-dark" type="text" id="membAge" name="membAge" placeholder="Enter Age"></td>
                    </tr>
                    <tr>
                        <th>회원 성별</th> 
                        <td>    
                            <input type="radio" class="membSex" name="membSex" value="남">남
                            <input type="radio" class="membSex" name="membSex" value="여">여
                        </td>   
                    </tr>
                </table>
                
                <br>
                    <div>
                        <input class="btn btn-dark" type="button" id="joinBtn" value="회원가입">
                        <input class="btn btn-danger" type="reset" value="초기화">
                    </div>
            </form>
            
        </div>
    </div>

    <script>
        // 페이지 로드시 
        $(document).ready(function() {
            if ($('#membDulpliId').val() != 'null') {
                // 중복ID일 경우
                if ($('#membDulpliId').val() == 'alreadyExistsId') {
                    alert('이미 존재하는 ID입니다.');
                    $('#membDupliIdCheck').attr('value', '');
                    $('#joinForm').hide();
                    return false;
                } else {
                    alert('사용 가능한 ID입니다.');
                    $('#membDupliIdCheck').attr('value', $('#membDulpliId').val());
                    $('#membId').attr('value', $('#membDulpliId').val());
                    $('#joinForm').show();
                    return;
                }
            } else {
                $('#joinForm').hide();
            }
        });
        
        // ID 공백일 경우
        $('#membCheckBtn').click(function() {
            if ($('#membDupliIdCheck').val() == '') {
                alert('생성할 ID를 입력해주세요.');
                return;
            }
        });
        
        // 회원가입 폼 유효성 검사
        $('#joinBtn').click(function() {
            if ($('#membPw').val() == '') {
                alert('비밀번호를 입력하세요');
                return;
            }
            
            if ($("select[name='membLevel']").val() == 'none') {
                alert('회원 등급을 선택하세요');
                return;
            }
            
            if ($('#membName').val() == '') {
                alert('회원명을 입력하세요');
                return;
            }
            
            if ($('#membAge').val() == '') {
                alert('회원 나이를 입력하세요');
                return;
            }
            
            var membSex = $('.membSex:checked');
            if (membSex.length == 0) {
                alert('회원 성별을 선택하세요');
                return;
            }
            
            // 회원가입
            $('#joinForm').submit();
        });
        
    </script>
</body>
</html>