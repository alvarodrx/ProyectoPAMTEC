package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "SetNotasCursoServlet", value = "/setNotasCursoServlet")
public class SetNotasCursoServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        String grupoId = (String) session.getAttribute("curso");

        String query = "{CALL spEstudiantes_PAM_getListaCurso(?) }";
        CallableStatement ps = connection.prepareCall(query);
        ps.setInt(1, Integer.parseInt(grupoId));
        ResultSet rs = ps.executeQuery();
        int cont = 1;
        while (rs.next()) {
            String estudianteId = rs.getString("PK_Cedula_Estudiantes_PAM");
            String nombreEstudiante = rs.getString("Nombre");
            out.print("" +
                    "<tr class=\"table-secondary\" id=\"row-"+estudianteId+"\">\n" +
                    "   <th scope=\"row\">"+cont+"</th>\n" +
                    "   <td>"+nombreEstudiante+"</td>\n" +
                    "       <td class=\"text-center\">\n" +
                    "               <input required type=\"number\" id=\"nota-"+estudianteId+"\" name=\"nota-"+estudianteId+"\" value=\"100\" min=\"1\" max=\"100\" data-decimals=\"1\" step=\"0.5\"> \n" +
                    "       </td>\n" +
                    "</tr>");
            cont+=1;
        }

    }
}
