package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetInfoCurso", value = "/getInfoCurso")
public class GetInfoCurso  extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String curso = req.getParameter("curso");
        String query = "{CALL spGet_Info_Grupo(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(curso));
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String nombreCurso = rs.getString(1);
            String codigoCurso = rs.getString(2);
            int numeroGrupo = rs.getInt(3);
            String nombreProfesor = rs.getString(4);
            String aula = rs.getString(5);
            String cupos = rs.getString(6);
            out.print("<table class=\"table table-md table-borderless w-75 mx-auto\">\n" +
                    "                                    <tbody>\n" +
                    "                                    <tr>\n" +
                    "                                        <td><b>Nombre del curso:</b></td>\n" +
                    "                                        <td>"+nombreCurso+"</td>\n" +
                    "<td></td>" +
                    "<td></td>" +
                    "                                        <td><b>C&oacute;digo de grupo:</b></td>\n" +
                    "                                        <td>"+codigoCurso+"</td>\n" +
                    "                                    </tr>\n" +
                    "                                    <tr>\n" +
                    "                                        <td><b>N&uacute;mero de grupo:</b></td>\n" +
                    "                                        <td>"+numeroGrupo+"</td>\n" +
                    "<td></td>" +
                    "<td></td>" +
                    "                                        <td><b>Profesor:</b></td>\n" +
                    "                                        <td>"+nombreProfesor+"</td>\n" +
                    "                                    </tr>\n" +
                    "                                    <tr>\n" +
                    "                                        <td><b>Lugar:</b></td>\n" +
                    "                                        <td>"+aula+"</td>\n" +
                    "<td></td>" +
                    "<td></td>" +
                    "                                        <td><b>Cupos:</b></td>\n" +
                    "                                        <td>"+cupos+"</td>\n" +
                    "                                    </tr>\n" +
                    "                                    </tbody>\n" +
                    "                                </table>");
        }


    }
}
