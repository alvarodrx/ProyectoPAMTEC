package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetEstudiantesActivosServlet", value = "/getEstudiantesActivosServlet")
public class GetEstudiantesActivosServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String query = "{CALL spGet_Informacion_EstudiantesPAM(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setBoolean(1, true);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String estudiantePK = rs.getString("PK_Cedula_Estudiantes_PAM");
            String nombreEstudiante = rs.getString("Nombre");
            out.print("<option value=\""+estudiantePK+"\""+(estudiantePK.equals(estudiantePK)? " selected " : "")+">"+nombreEstudiante+"</option>");

        }

    }
}