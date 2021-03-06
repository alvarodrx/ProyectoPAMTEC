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
        out.print( "<div class=\"row\"> <div class=\"column\"> <br> <h5>Asistentes del Curso</h5> <br> </div></div>" +
                "<table class=\"table table-md table-borderless w-75 mx-auto\">\n" +
                "                                    <tbody>\n" );
        while (rs.next()) {
            String asistentePK = rs.getString("PK_Usuarios");
            String nombreAsistente = rs.getString("Nombre_Usuario");
            out.print("                                    <tr>\n" +
                    "                                        <td><b>Nombre del asistente:</b></td>\n" +
                    "                                        <td>"+nombreAsistente+"</td>\n" +
                    "<td></td>" +
                    "<td></td>" +
                    "                                        <td><b>C&eacute;dula:</b></td>\n" +
                    "                                        <td>"+asistentePK+"</td>\n" +
                    "                                    </tr>\n");

        }
        out.println("                                    </tbody>\n" +
                "                                </table>");

    }
}
