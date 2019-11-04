package com.vinculacion.pamtec.sisasServlets;

import com.google.appengine.api.datastore.PreparedQuery;
import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetCursos", value = "/getCursos")
public class GetCursosServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String tipo = req.getParameter("tipo");
        String userId = req.getParameter("userId");

        if (tipo != null && tipo.equals("LISTA")) {
            String query = "{CALL spGrupos_getListaCursosDeUsuario(?) }";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(userId));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String grupoId = rs.getString("PK_Grupos");
                String cursoNombre = rs.getString("Informacion_Curso");
                String tipoUser = rs.getString("Tipo");
                out.print("<tr class=\"table-light\" onclick=\"goToCurso('" + grupoId + "', '" + cursoNombre + "', '" + tipoUser + "');\">\n" +
                        "<td scope=\"row\">\n" +
                        "<i class=\"material-icons\">list_alt</i>\n" +
                        "</td>\n" +
                        "<td>" + cursoNombre + "</td>\n" +
                        "</tr>");
                if (rs.next()) {
                    grupoId = rs.getString("PK_Grupos");
                    cursoNombre = rs.getString("Informacion_Curso");
                    tipoUser = rs.getString("Tipo");
                    out.print("<tr class=\"table-dark\" onclick=\"goToCurso('" + grupoId + "', '" + cursoNombre + "', '" + tipoUser + "');\">\n" +
                            "<td scope=\"row\">\n" +
                            "<i class=\"material-icons\">list_alt</i>\n" +
                            "</td>\n" +
                            "<td>" + cursoNombre + "</td>\n" +
                            "</tr>");
                }
            }
        }

    }
}
