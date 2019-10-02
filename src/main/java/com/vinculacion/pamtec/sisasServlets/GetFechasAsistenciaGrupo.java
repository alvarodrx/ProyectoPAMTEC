package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;

@WebServlet(name = "GetFechaAsistenciaGrupo", value = "/getFechaAsistenciaGrupo")
public class GetFechasAsistenciaGrupo extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String curso = req.getParameter("curso");
        String query = "{CALL spGet_Fecha_Asistencia_Grupo(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(curso));
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            Date fechaClases = rs.getDate(1);
            out.print("<option>"+fechaClases.toString()+"</option>");
        }
    }
}
