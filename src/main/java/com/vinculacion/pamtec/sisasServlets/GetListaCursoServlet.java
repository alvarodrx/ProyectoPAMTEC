package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;

@WebServlet(name = "GetListaCurso", value = "/getListaCurso")
public class GetListaCursoServlet extends BaseServlet {
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
                    "           <label class=\"container mx-auto\">\n" +
                    "               <input type=\"radio\" id=\"radio-"+estudianteId+"\" name=\"radio-"+estudianteId+"\" value=\"Presente\">\n" +
                    "               <span class=\"checkmark\"></span>\n" +
                    "           </label>\n" +
                    "       </td>\n" +
                    "       <td class=\"text-center\">\n" +
                    "           <label class=\"container mx-auto\">\n" +
                    "               <input type=\"radio\" id=\"radio-"+estudianteId+"\" name=\"radio-"+estudianteId+"\" value=\"Ausente\">\n" +
                    "               <span class=\"checkmark\"></span>\n" +
                    "           </label>\n" +
                    "   </td>\n" +
                    "   <td class=\"text-center\">\n" +
                    "       <label class=\"container mx-auto\">\n" +
                    "           <input type=\"radio\" name=\"radio-"+estudianteId+"\" name=\"radio-"+estudianteId+"\" value=\"Justificado\" onclick=\"showModalJustificacion("+estudianteId+", '#estudianteModal');\">\n" +
                    "           <span class=\"checkmark\"></span>\n" +
                    "       </label>\n" +
                    "   </td>\n" +
                    "</tr>");
            cont+=1;
        }

        String query2 = "{CALL spAsistentes_Grupo_getListaCurso(?) }";
        CallableStatement ps2 = connection.prepareCall(query2);
        ps2.setInt(1, Integer.parseInt(grupoId));
        ResultSet rs2 = ps2.executeQuery();
        int cont2 = 1;
        while (rs2.next()) {
            String asistentePK = rs2.getString("PK_Usuarios");
            String nombreAsistente = rs2.getString("Nombre_Usuario");
            out.print("" +
                    "<tr class=\"table-success\" id=\"row-"+asistentePK+"\">\n" +
                    "   <th scope=\"row\">"+cont2+"</th>\n" +
                    "   <td>"+nombreAsistente+"</td>\n" +
                    "       <td class=\"text-center\">\n" +
                    "           <label class=\"container mx-auto\">\n" +
                    "               <input type=\"radio\" id=\"radioAsis-"+asistentePK+"\" name=\"radioAsis-"+asistentePK+"\" value=\"Presente\">\n" +
                    "               <span class=\"checkmark\"></span>\n" +
                    "           </label>\n" +
                    "       </td>\n" +
                    "       <td class=\"text-center\">\n" +
                    "           <label class=\"container mx-auto\">\n" +
                    "               <input type=\"radio\" id=\"radioAsis-"+asistentePK+"\" name=\"radioAsis-"+asistentePK+"\" value=\"Ausente\">\n" +
                    "               <span class=\"checkmark\"></span>\n" +
                    "           </label>\n" +
                    "   </td>\n" +
                    "   <td class=\"text-center\">\n" +
                    "       <label class=\"container mx-auto\">\n" +
                    "           <input type=\"radio\" name=\"radioAsis-"+asistentePK+"\" name=\"radioAsis-"+asistentePK+"\" value=\"Justificado\" onclick=\"showModalJustificacion("+asistentePK+", '#asistenteModal');\">\n" +
                    "           <span class=\"checkmark\"></span>\n" +
                    "       </label>\n" +
                    "   </td>\n" +
                    "</tr>");
            cont2+=1;
        }

    }
}
