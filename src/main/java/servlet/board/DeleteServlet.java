package servlet.board;

import com.google.gson.JsonObject;
import connector.ConnectionMaker;
import connector.MySqlConnectioMaker;
import controller.BoardController;
import model.BoardDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.NoSuchFileException;

@WebServlet(name = "DeleteServlet", value = "/board/delete")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter writer = response.getWriter();

        JsonObject resp = new JsonObject();
        String status = "";

        try {
            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MySqlConnectioMaker();
            BoardController boardController = new BoardController(connectionMaker);
            BoardDTO b = boardController.selectOne(id);

            if (b == null || b.getWriterId() != logIn.getId()) {
                throw new NullPointerException();
            }

            boardController.delete(id);
            status = "success";

        } catch (Exception e) {
            status = "fail";
        }

        resp.addProperty("status", status);
        writer.print(resp);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
