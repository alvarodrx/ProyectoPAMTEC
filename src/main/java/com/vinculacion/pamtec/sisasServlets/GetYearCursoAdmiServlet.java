package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "/GetYearCursoAdmiServlet", value = "/getYearCursoAdmiServlet")
public class GetYearCursoAdmiServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");


        String cursoSelect = req.getParameter("cursoSelect");
        String query = "{CALL spGet_Years_Curso(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setString(1, cursoSelect);
        ResultSet rs = ps.executeQuery();

        while (rs.next()){
            String anno = rs.getString("Anno");
            out.print("<option value=\""+cursoSelect+"\""+(cursoSelect .equals(cursoSelect)? " selected " : "")+">"+anno+"</option>");

        }
    }
}
