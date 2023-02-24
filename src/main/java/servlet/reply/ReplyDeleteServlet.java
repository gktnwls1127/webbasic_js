package servlet.reply;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.ReplyController;
import model.ReplyDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ReplyDeleteServlet", value = "/reply/delete")
public class ReplyDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        JsonObject object = new JsonObject();
        PrintWriter writer = response.getWriter();

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            ReplyController replyController = new ReplyController(connectionMaker);
            ReplyDTO temp = replyController.selectOne(id);
            if (temp == null || temp.getWriterId() != logIn.getId()) {
                throw new NullPointerException();
            }

            replyController.delete(id);

            status = "success";

        } catch (Exception e) {
            status = "fail";
        }
        object.addProperty("status", status);
        writer.print(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
