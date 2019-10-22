package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetInformacionEstudiantesPAMServlet", value = "/getInformacionEstudiantesPAMServlet")
public class GetInformacionEstudiantesPAMServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String estadoEstudiantes = req.getParameter("estudiantePAM");
        Boolean estadoEst = false;
        if(estadoEstudiantes.equals("Activos") || estadoEstudiantes.equals("Inactivos") ) {
            if (estadoEstudiantes.equals("Activos")) {
                estadoEst = true;
            }
            String query = "{CALL spGet_Informacion_EstudiantesPAM(?) }";
            CallableStatement ps = connection.prepareCall(query);
            ps.setBoolean(1, estadoEst);
            ResultSet rs = ps.executeQuery();
            out.print("<label><b>Estudiantes PAM "+estadoEstudiantes+"</b></label>");
            while (rs.next()) {
                String asistentePK = rs.getString("PK_Cedula_Estudiantes_PAM");
                String nombreEstudiante = rs.getString("Nombre");
                int edad = rs.getInt("Edad");
                String sexo = rs.getString("Sexo");
                String lugar = rs.getString("Lugar_Procedencia");
                String correo = rs.getString("Correo_Electronico");

                out.print(
                        "<div class=\"row\"> " +
                        "<div class=\"column\"> " +
                        "<b class=\"izquierda\"> Nombre de Estudiante:</b> " +
                        "<label id=\"labelNombreCurso\" class=\"derecha\"  >" + asistentePK +
                        "</label> <br>  </div>" +
                        "<div class=\"column\"> " +
                        "<b class=\"izquierda\"> C&eacute;dula:</b> " +
                        "<label id=\"labelNombreCurso\" class=\"derecha\"  >" + nombreEstudiante +
                        "</label> <br> </div>" +
                        " </div>");
            }
        }

    }
}
