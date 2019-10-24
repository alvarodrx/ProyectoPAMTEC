package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetGruposAdminServlet", value = "/getGruposAdminServlet")
public class GetGruposAdminServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");


        String cursoSelect = req.getParameter("cursoSelect");
        String yearSelect = req.getParameter("annoSelect");
        String semestreSelect = req.getParameter("semestreSelect");
        int semestreM = 1;
        if(semestreSelect.equals("II")) semestreM = 2;
        String query = "{CALL spGet_Grupos(?,?,?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setString(1, cursoSelect);
        ps.setString(2, yearSelect);
        ps.setInt(3,semestreM);
        ResultSet rs = ps.executeQuery();

        while (rs.next()){
            String PK_Grupo = rs.getString("PK_Grupos");
            String grupoNombre = rs.getString("Informacion_Curso");
            out.print("<option name=\"groupS\" value=\""+PK_Grupo+"\""+(PK_Grupo.equals(PK_Grupo)? " selected " : "")+">"+grupoNombre+"</option>");

        }
    }
}
