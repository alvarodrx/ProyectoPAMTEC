package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetInfoCurso", value = "/getInfoCurso")
public class GetInfoCurso  extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String curso = req.getParameter("curso");
        String query = "{CALL spGet_Info_Grupo(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(curso));
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String nombreCurso = rs.getString(1);
            String codigoCurso = rs.getString(2);
            int numeroGrupo = rs.getInt(3);
            String nombreProfesor = rs.getString(4);
            out.print("<div class=\"row\"> " +
                      "<div class=\"column\"> " +
                      "<b class=\"izquierda\"> Nombre del curso:</b> " +
                      "<label id=\"labelNombreCurso\" class=\"derecha\" style=\"margin-right:2.5em\" >" +nombreCurso+
                      "</label> <br> " +
                      "<b class=\"izquierda\">N&uacute;mero de grupo:</b> " +
                      "<label id=\"labelNumeroGrupo\" class=\"derecha\" style=\"margin-right:2.5em\" >" +Integer.toString(numeroGrupo)+
                      "</label> <br> </div>" +
                      "<div class=\"column\"> " +
                      "<b class=\"izquierda\"> C&oacute;digo:</b> " +
                      "<label id=\"labelNombreCurso\" class=\"derecha\" style=\"margin-right:2.5em\" >" +codigoCurso+
                      "</label> <br> " +
                      "<b class=\"izquierda\">Profesor:</b> " +
                      "<label id=\"labelNumeroGrupo\" class=\"derecha\" style=\"margin-right:2.5em\" >" +nombreProfesor+
                      "</label> <br> </div>" +
                      " </div>");
        }

    }
}
