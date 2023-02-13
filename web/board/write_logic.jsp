<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오후 3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");
  UserDTO logIn = (UserDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  BoardController boardController = new BoardController(connectionMaker);
  BoardDTO b = new BoardDTO();

  b.setWriterId(logIn.getId());
  b.setTitle(request.getParameter("title"));
  b.setContent(request.getParameter("content"));

  boardController.insert(b);

  response.sendRedirect("/board/printList.jsp");

%>
</body>
</html>
