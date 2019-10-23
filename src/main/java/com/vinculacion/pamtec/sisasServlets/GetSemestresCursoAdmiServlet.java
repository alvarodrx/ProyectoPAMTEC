package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetSemestresCursoAdmiServlet", value = "/getSemestresCursoAdmiServlet")
public class GetSemestresCursoAdmiServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");


        String cursoSelect = req.getParameter("cursoSelect");
        String yearSelect = req.getParameter("annoSelect");
        String query = "{CALL spGet_Semester_Year_Curso(?,?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setString(1, cursoSelect);
        ps.setString(2, yearSelect);
        ResultSet rs = ps.executeQuery();

        while (rs.next()){
            int semestre = rs.getInt("Semestre");
            String semestreM = "I";
            if(semestre == 2) semestreM = "II";
            out.print("<option value=\""+semestreM+"\" selected >"+semestreM+"</option>");

        }
    }
}
