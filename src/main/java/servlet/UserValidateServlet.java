package servlet;

import com.google.gson.JsonObject;
import com.mysql.cj.protocol.x.XMessage;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.UserController;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "MemberValidate", value = "/user/validate")
public class MemberValidateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setCharacterEncoding("UTF-8");
        request.setCharacterEncoding("UTF-8");
        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        UserController userController = new UserController(connectionMaker);

        String username = request.getParameter("username");
        boolean result = userController.validateUsername(username);

        String message;

        if (result) {
            message = "회원가입 가능";
        } else {
            message = "중복된 아이디입니다.";
        }


        PrintWriter writer = response.getWriter();

        //message에 포함된 내용
        //1. 결과
        //2. 성공시 결과 내용
        JsonObject object = new JsonObject();
        object.addProperty("status", "success");
        object.addProperty("result", result);
        object.addProperty("message" , message);

        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
