<%@ page import="model.UserDTO" %>
<%@ page import="connector.ConnectionMaker" %>>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.ReplyController" %>
<%@ page import="model.ReplyDTO" %><%--
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
  UserDTO logIn = (UserDTO) session.getAttribute("logIn");
  if (logIn == null){
    response.sendRedirect("/index.jsp");
  }

  int boardId = Integer.parseInt(request.getParameter("boardId"));
  String content = request.getParameter("content");

  ConnectionMaker connectionMaker = new MySqlConnectioMaker();
  ReplyController replyController = new ReplyController(connectionMaker);
  ReplyDTO replyDTO = new ReplyDTO();

  replyDTO.setWriterId(logIn.getId());
  replyDTO.setBoardId(boardId);
  replyDTO.setContent(content);

  replyController.insert(replyDTO);

  response.sendRedirect("/board/printOne.jsp?id="+boardId);

%>
</body>
</html>
