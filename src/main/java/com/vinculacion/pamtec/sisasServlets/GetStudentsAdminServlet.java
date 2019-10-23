package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetStudentsAdminServlet", value = "/getStudentsAdminServlet")
public class GetStudentsAdminServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");


        String cursoSelect = req.getParameter("curso");
        String query = "{CALL spEstudiantes_PAM_getListaCurso(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(cursoSelect));
        ResultSet rs = ps.executeQuery();

        while (rs.next()){
            String PK_Student = rs.getString("PK_Cedula_Estudiantes_PAM");
            String nombreStudent = rs.getString("Nombre");
            out.print("<option value=\""+PK_Student+"\""+(PK_Student.equals(PK_Student)? " selected " : "")+">"+nombreStudent+"</option>");

        }
    }
}
