package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;
import org.json.JSONObject;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.List;

@WebServlet("/getChartData")
public class GetChartsDataServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String tipo = req.getParameter("tipo");

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        String grupoId = (String) session.getAttribute("curso");

        if (tipo != null && tipo.equals("CHART1")){
            String entrada = req.getParameter("semestre");
            String[] semestreSelected = entrada.replace("Semestre ","").split(" - ");
            String semestre = semestreSelected[0];
            String anno = semestreSelected[1];
            String query = "SELECT SUM(CASE WHEN e.Sexo = 'F' THEN 1 ELSE 0 END) AS Mujeres, SUM(CASE WHEN e.Sexo = 'M' THEN 1 ELSE 0 END) AS Hombres " +
                    "FROM Estudiantes_PAM e " +
                    "INNER JOIN Estudiantes_PAM_Grupo epg " +
                    "ON e.PK_Cedula_Estudiantes_PAM = epg.FK_Cedula_Estudiantes_PAM " +
                    "INNER JOIN Grupos g " +
                    "ON epg.FK_Grupos = g.PK_Grupos " +
                    "WHERE g.Anno = "+anno+" AND g.Semestre = "+semestre+";";
            CallableStatement ps = connection.prepareCall(query);
            ResultSet resultSet = ps.executeQuery();
            JSONObject respuesta = new JSONObject();
            while (resultSet.next()){
                int mujeres = resultSet.getInt("Mujeres");
                int hombres = resultSet.getInt("Hombres");
                respuesta.put("Hombres", hombres);
                respuesta.put("Mujeres", mujeres);
            }
            out.println(respuesta.toString());
            return;
        }


        if (tipo != null && tipo.equals("CHART2")){
            String entrada = req.getParameter("semestre");
            String[] semestreSelected = entrada.replace("Semestre ","").split(" - ");
            String semestre = semestreSelected[0];
            String anno = semestreSelected[1];
            String query = "SELECT SUM(CASE WHEN epg.Estado_Curso = 1 THEN 1 ELSE 0 END) AS Activos, SUM(CASE WHEN epg.Estado_Curso = 0 THEN 1 ELSE 0 END) AS Abandonos " +
                    "FROM Estudiantes_PAM_Grupo epg " +
                    "INNER JOIN Grupos g " +
                    "ON epg.FK_Grupos = g.PK_Grupos " +
                    "WHERE g.Anno = "+anno+" AND g.Semestre = "+semestre+";";
            CallableStatement ps = connection.prepareCall(query);
            ResultSet resultSet = ps.executeQuery();
            JSONObject respuesta = new JSONObject();
            while (resultSet.next()){
                int activos = resultSet.getInt("Activos");
                int abandonos = resultSet.getInt("Abandonos");
                respuesta.put("Activos", activos);
                respuesta.put("Abandonos", abandonos);
            }
            out.println(respuesta.toString());
            return;
        }

        if (tipo != null && tipo.equals("CHART1_DOWNLOAD")) {
            String filename = "grafico1.csv";
            resp.setHeader("content-type", "text/csv");
            resp.setHeader("content-disposition", "attachment;filename=\"" + filename + "\"");

            String entrada = req.getParameter("semestre");
            String[] semestreSelected = entrada.replace("Semestre ","").split(" - ");
            String semestre = semestreSelected[0];
            String anno = semestreSelected[1];
            String query = "SELECT SUM(CASE WHEN e.Sexo = 'F' THEN 1 ELSE 0 END) AS Mujeres, SUM(CASE WHEN e.Sexo = 'M' THEN 1 ELSE 0 END) AS Hombres " +
                    "FROM Estudiantes_PAM e " +
                    "INNER JOIN Estudiantes_PAM_Grupo epg " +
                    "ON e.PK_Cedula_Estudiantes_PAM = epg.FK_Cedula_Estudiantes_PAM " +
                    "INNER JOIN Grupos g " +
                    "ON epg.FK_Grupos = g.PK_Grupos " +
                    "WHERE g.Anno = "+anno+" AND g.Semestre = "+semestre+";";
            CallableStatement ps = connection.prepareCall(query);
            ResultSet rs = ps.executeQuery();
            List<List<String>> csv = resultSetToList(rs);
            writeCsv(csv, ',', out, true, "Matricula por genero: "+entrada);
            return;
        }

        if (tipo != null && tipo.equals("CHART2_DOWNLOAD")) {
            String filename = "grafico2.csv";
            resp.setHeader("content-type", "text/csv");
            resp.setHeader("content-disposition", "attachment;filename=\"" + filename + "\"");

            String entrada = req.getParameter("semestre");
            String[] semestreSelected = entrada.replace("Semestre ","").split(" - ");
            String semestre = semestreSelected[0];
            String anno = semestreSelected[1];
            String query = "SELECT SUM(CASE WHEN epg.Estado_Curso = 1 THEN 1 ELSE 0 END) AS Activos, SUM(CASE WHEN epg.Estado_Curso = 0 THEN 1 ELSE 0 END) AS Abandonos " +
                    "FROM Estudiantes_PAM_Grupo epg " +
                    "INNER JOIN Grupos g " +
                    "ON epg.FK_Grupos = g.PK_Grupos " +
                    "WHERE g.Anno = "+anno+" AND g.Semestre = "+semestre+";";
            CallableStatement ps = connection.prepareCall(query);
            ResultSet rs = ps.executeQuery();
            List<List<String>> csv = resultSetToList(rs);
            writeCsv(csv, ',', out, true, "Matricula vs abandonos: "+entrada);
            return;
        }

    }
}
