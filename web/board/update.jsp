<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="controller.BoardController" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

    <%
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        BoardController boardController = new BoardController(connectionMaker);

        BoardDTO b = boardController.selectOne(id);
        if (b.getWriterId() != logIn.getId()){
            response.sendRedirect("/board/printOne.jsp?id=" + id);
        }
    %>
    <title><%=b.getTitle()%> 글 수정하기</title>
</head>
<body>
<div class="container-fluid">
    <div class="row align-items-center vh-100 justify-content-center">
        <div class="row">
            <div class="col-10">g
                <form action="/board/update_logic.jsp?id=<%=id%>" method="post">
                    <table class="table table-striped table-dark">
                        <tr>
                            <th class="col-2">글번호</th>
                            <td class="col-10"><%=b.getId()%></td>
                        </tr>
                        <tr>
                            <th>제목</th>
                            <td><input type="text" name="title" value="<%=b.getTitle()%>" class="form-control"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea name="content" class="form-control">
                                    <%=b.getContent()%>
                                </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <button class="btn btn-outline-success">수정하기</button>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
