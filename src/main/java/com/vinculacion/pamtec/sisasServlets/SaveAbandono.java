package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

@WebServlet(name = "SaveAbandono", value = "/saveAbandono")
public class SaveAbandono extends BaseServlet {

    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        String grupoId = (String) session.getAttribute("curso");
        String cedula_user = (String) session.getAttribute("userId");
        String cedula_estudiantePAM = req.getParameter("estudiantePAM");
        String comentario = req.getParameter("textAreaMotivo");
        if(comentario == null)
            comentario = " ";
        PreparedStatement ps = connection.prepareStatement("{call spRegistros_Abandono_setAbandono(?,?,?,?)}");
        ps.setInt(1, Integer.parseInt(cedula_user));
        ps.setInt(2, Integer.parseInt(cedula_estudiantePAM));
        ps.setInt(3, Integer.parseInt(grupoId));
        ps.setString(4, comentario);


        executeOperation(ps);
    }
}
