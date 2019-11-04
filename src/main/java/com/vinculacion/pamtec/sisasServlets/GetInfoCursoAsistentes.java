package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetInfoCursoAsistenes", value = "/getInfoCursoAsistentes")
public class GetInfoCursoAsistentes extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String curso = req.getParameter("curso");
        String query = "{CALL spAsistentes_Grupo_getListaCurso(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(curso));
        ResultSet rs = ps.executeQuery();
        out.print( "<div class=\"row\"> <div class=\"column\"> <br> <b style=\"text-align:left;\" >Asistentes del Curso</b> <br> </div></div>");
        while (rs.next()) {
            String asistentePK = rs.getString("PK_Usuarios");
            String nombreAsistente = rs.getString("Nombre_Usuario");
            out.print("<div class=\"row\"> " +
                    "<div class=\"column\"> " +
                    "<b aling=\"left\" class=\"izquierda\"> Nombre del Asistente: </b> " +
                    "<p style=\"text-align:left;\" class=\"izquierda\"> "+nombreAsistente+" </p> " +
                    "<br> </div>" +
                    "<div class=\"column\"> " +
                    "<b aling=\"left\" class=\"izquierda\"> C&eacute;dula: </b> " +
                    "<p style=\"text-align:left;\" class=\"izquierda\"> "+asistentePK+" </p> " +
                    "<br> </div>" +
                    " </div>");
        }

    }
}
