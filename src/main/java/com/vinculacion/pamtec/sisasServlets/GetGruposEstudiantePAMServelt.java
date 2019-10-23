package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetGruposEstudiantePAMServelt", value = "/getGruposEstudiantePAMServelt")
public class GetGruposEstudiantePAMServelt extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String idEstudiantePAM = req.getParameter("estudiantePAM");
        String query = "{CALL spGet_Cursos_Estudiantes_PAM(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1,Integer.parseInt(idEstudiantePAM));
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String PK_Grupos = rs.getString("PK_Grupos");
            String Informacion_Curso = rs.getString("Informacion_Curso");
            out.print("<option value=\""+PK_Grupos+"\""+(PK_Grupos.equals(PK_Grupos)? " selected " : "")+">"+Informacion_Curso+"</option>");

        }

    }
}