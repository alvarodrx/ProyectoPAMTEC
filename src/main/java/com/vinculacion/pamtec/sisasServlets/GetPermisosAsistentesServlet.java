package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetPermisosAsistentes", value = "/getPermisosAsistentes")
public class GetPermisosAsistentesServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        PrintWriter out = resp.getWriter();
        String query = "{CALL spGet_Asistentes_Permisos() }";
        CallableStatement ps = connection.prepareCall(query);
        ResultSet rs = ps.executeQuery();

        int cont = 1;
        while (rs.next()) {
            String idGrupo = rs.getString("FK_Grupos");
            String nombreCurso = rs.getString("Nombre_Curso");
            String asistentePK = rs.getString("FK_Asitente_Id");
            String nombreAsistente = rs.getString("Nombre_Usuario");
            int permiso = rs.getInt("Permiso_Acceso");
            String permisoAsistente= "";
            if(permiso==1) permisoAsistente="checked ";
            out.print("" +
                    "<tr class=\"table-secondary\" id=\"row-"+asistentePK+"\">\n" +
                    "   <th scope=\"row\">"+cont+"</th>\n" +
                    "   <td>"+nombreCurso+"</td>\n" +
                    "   <td>"+nombreAsistente+"</td>\n" +
                    "   <td class=\"text-center\">\n" +
                    "<div>\n"+
                    "<input type=\"checkbox\"  id=\"chek-"+idGrupo+"-"+asistentePK+"-\" name=\"check-"+idGrupo+"-"+asistentePK+"\" value=\"Permiso\" "+permisoAsistente+" >\n"+
                    "<label> Permiso de uso </label>\n"+
                    "</div> </td>\n" +
                    "</tr>");
            cont+=1;
        }



    }
}
