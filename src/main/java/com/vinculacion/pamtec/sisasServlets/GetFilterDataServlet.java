package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet("/getFilterData")
public class GetFilterDataServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String tipo = req.getParameter("tipo");

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        String grupoId = (String) session.getAttribute("curso");

        if (tipo != null && tipo.equals("EstudiantesPAM_Curso")){
            String estudiantePAM = req.getParameter("estudiantePAM");
            String query = "{CALL spEstudiantes_PAM_getListaCurso(?) }";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(grupoId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                String estudianteId = rs.getString("PK_Cedula_Estudiantes_PAM");
                String nombreEstudiante = rs.getString("Nombre");
                out.print("<option value=\""+estudianteId+"\""+(estudiantePAM.equals(estudianteId)? " selected " : "")+">"+nombreEstudiante+"</option>");
            }
        }

    }
}
