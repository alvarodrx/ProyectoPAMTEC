package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "/GetAdminCursos", value = "/getAdminCursos")
public class GetAdmiCursosServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");

        String query = "{CALL spGet_Cursos() }";
        CallableStatement ps = connection.prepareCall(query);
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            String idCurso = rs.getString("PK_Codigo_Curso");
            String nombreCurso = rs.getString("Nombre_Curso");
            out.print("<option value=\""+idCurso+"\""+(idCurso.equals(idCurso)? " selected " : "")+">"+nombreCurso+"</option>");

        }
    }
}
