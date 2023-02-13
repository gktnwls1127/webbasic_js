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
    <title>Title</title>
</head>
<body>
<%
  UserDTO logIn = (UserDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  int id = Integer.parseInt(request.getParameter("id"));

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  BoardController boardController = new BoardController(connectionMaker);

  BoardDTO b = boardController.selectOne(id);
  if (b.getWriterId() == logIn.getId()){
    boardController.delete(id);
  }

  response.sendRedirect("/board/printList.jsp");
%>
</body>
</html>
