package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateSessionServlet", value = "/updateSession")
public class UpdateSessionServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        validateSession(req);
    }
}
