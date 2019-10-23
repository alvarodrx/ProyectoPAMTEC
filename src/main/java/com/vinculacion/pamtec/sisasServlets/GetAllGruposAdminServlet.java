package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetAllGruposAdminServlet", value = "/getAllGruposAdminServlet")
public class GetAllGruposAdminServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        String query = "{CALL spGet_All_Grupos() }";
        CallableStatement ps = connection.prepareCall(query);
        ResultSet rs = ps.executeQuery();

        while (rs.next()){
            String PK_Grupo = rs.getString("PK_Grupos");
            String grupoNombre = rs.getString("Informacion_Curso");
            out.print("<option value=\""+PK_Grupo+"\""+(PK_Grupo.equals(PK_Grupo)? " selected " : "")+">"+grupoNombre+"</option>");

        }
    }
}
