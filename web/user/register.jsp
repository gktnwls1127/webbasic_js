<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script>
        let result = false;

        function validateUsername(username){
            var data = {
                "username": username
            };

            if (username.length >= 5) {
                return true;
            }
            $.ajax({
                url: "/user/validate",
                type: "get",
                data: data,
                success: function (message) {
                    let jsonResult = JSON.parse(message)

                    if (!jsonResult.result) {
                        Swal.fire({title: '실패', text: jsonResult.message});
                    }
                }
            });
        }

        function validatePassword(password){
            if (password.includes('!')){
                return true;
            }
            return false;
        }

        function validateInput(){
            let username = document.getElementById("username");
            let password = document.getElementById("password");

            result = validateUsername(username.value) && validatePassword(password.value);

            if (result){
                document.forms[0].submit(); // 해당 문서의 form 태그중 0번째를 제출
            } else {
                Swal.fire({title : "!!! 오류 !!!", text: "잘못 입력하셨습니다.", icon : 'error'});
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row vh-100 align-items-center text-center">
        <div class="row justify-content-center">
            <form action="/user/register_logic.jsp" method="post">
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="username" name="username" class="form-control" placeholder="아이디">
                            <label for="username">아이디</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호">
                            <label for="username">비밀번호</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임">
                            <label for="username">닉네임</label>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="btn btn-outline-primary col-6 m-1" onclick="validateInput()">회원가입</div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
