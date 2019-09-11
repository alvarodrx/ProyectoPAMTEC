package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "SetCurso", value = "/setCurso")
public class SetCursoServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String curso = req.getParameter("curso");
        String cursoName = req.getParameter("cursoName");

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        session.setAttribute("curso", curso);
        session.setAttribute("cursoName", cursoName);

        resp.sendRedirect("/SISAS/profesor/");
    }
}
