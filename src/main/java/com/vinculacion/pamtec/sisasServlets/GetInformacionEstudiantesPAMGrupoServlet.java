package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetInformacionEstudiantesPAMGrupoServlet", value = "/getInformacionEstudiantesPAMGrupoServlet")
public class GetInformacionEstudiantesPAMGrupoServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String grupoId = req.getParameter("curso");

            String query = "{CALL spGet_Informacion_EstudiantesPAM_Grupo(?) }";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(grupoId));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String estudiantePK = rs.getString("PK_Cedula_Estudiantes_PAM");
                String nombreEstudiante = rs.getString("Nombre");
                int edad = rs.getInt("Edad");
                String sexo = rs.getString("Sexo");
                String lugar = rs.getString("Lugar_Procedencia");
                String correo = rs.getString("Correo_Electronico");

                out.print(
                        "<div class=\"card\" w-75 rounded-lg shadow \" >"
                                +"<div class=\"card-body\">"
                                +"<h5 class=\"card-title\">"+nombreEstudiante+"</h5>"
                                +"<h6 class=\"card-subtitle mb-2 text-muted\"> Cedula:"+estudiantePK+"</h6>"
                                +"<div class=\"row\">"
                                +"<div class=\"column\">"
                                +"<p class=\"card-text text-left \"> Edad: "+edad+"<p>"
                                +"<p class=\"card-text text-left \"> Sexo: "+sexo+"<p>"
                                +"</div> <div class=\"column\">"
                                +"<p class=\"card-text text-left \"> Lugar de Procedencia: "+lugar+"<p>"
                                +"<p class=\"card-text text-left \"> Correo: "+correo+"<p>"
                                +"</div>"
                                +"</div>"
                                +" </div> </div>");
            }


    }
}
