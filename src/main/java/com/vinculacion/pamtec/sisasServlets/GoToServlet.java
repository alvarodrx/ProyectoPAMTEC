package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Calendar;


@WebServlet(name = "GoTo", value = "/goto")
public class GoToServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String page = req.getParameter("page");
        String paramName1 = req. getParameter("paramName1");
        String paramVal1 = req. getParameter("paramVal1");

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        if (paramVal1 != null && !paramVal1.equals("")) {
            session.setAttribute(paramName1, paramVal1);
        }
        resp.sendRedirect(page);
    }
}
