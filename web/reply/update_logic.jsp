<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.BoardController" %>
<%@ page import="model.BoardDTO" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-02-10
  Time: 오후 2:43
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
  ReplyController replyController = new ReplyController(connectionMaker);
  ReplyDTO r = replyController.selectOne(id);
  if (r.getWriterId() != logIn.getId()){
    response.sendRedirect("/reply/printOne.jsp?id="+id);
  }

  r.setContent(request.getParameter("content"));

  replyController.update(r);

  response.sendRedirect("/reply/printOne.jsp?id="+id);
%>
</body>
</html>
