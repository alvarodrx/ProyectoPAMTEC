package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Date;
import java.sql.ResultSet;

@WebServlet(name = "GetFechasAsistenciaGrupoAdmi", value = "/getFechasAsistenciaGrupoAdmi")
public class GetFechasAsistenciaGrupoAdmi extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String grupo = req.getParameter("grupo");
        String query = "{CALL spGet_Fecha_Asistencia_Grupo(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(grupo));
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            Date fechaClases = rs.getDate(1);
            String fecha = "";
            out.print("<option value='"+fechaClases.toString()+"' selected >"+fechaClases.toString()+"</option> ");
        }
    }
}
