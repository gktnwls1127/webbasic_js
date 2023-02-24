<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="controller.BoardController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>글 수정하기</title>
    <script src="/assets/js%20library/build/ckeditor.js"></script>
    <script src="/assets/js/board/update.js"></script>
    <style>
        .ck-editor__editable {
            height: 500px;
            color: black;
        }
    </style>
</head>
<body onload="initPage()">
<div class="container-fluid">
    <div class="row align-items-center vh-100 justify-content-center">
        <div class="col-10">
                <table class="table table-striped table-dark">
                    <tr>
                        <th class="col-2">글번호</th>
                        <td class="col-10"><input type="text" id="input-id" class="form-control w-100" disabled>
                        </td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td><input type="text" id="input-title" class="form-control w-100"></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                                <textarea name="content" id="editor">
                                </textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            <div class="btn btn-outline-success" onclick="updateBoard()">수정하기</div>
                        </td>
                    </tr>
                </table>
        </div>
    </div>
</div>
<%--<script>--%>
<%--    ClassicEditor.create(document.querySelector('#editor')).catch(error => {--%>
<%--        console.log(error)--%>
<%--    });--%>
<%--    let tag = document.querySelectorAll('td')--%>
<%--    tag.forEach(e => {--%>
<%--        console.log(e)--%>
<%--    })--%>
<%--    $($('td')[0]).text('내맘대로');--%>
<%--    $('input[name="title"]').val("바꾼다!") // 특정 속성값을 찾아서 일치하는 값을 변경하기--%>
<%--</script>--%>
</body>
</html>
