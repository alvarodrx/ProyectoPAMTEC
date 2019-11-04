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
            String query = "{CALL spGet_Matricula_Por_Genero("+anno+", "+semestre+")}";
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
            String query = "{ CALL spGet_Matricula_Vs_Abandono(?,?)}";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(anno));
            ps.setInt(2, Integer.parseInt(semestre));
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

        if (tipo != null && tipo.equals("CHART3")){
            String entrada = req.getParameter("semestre");
            String[] semestreSelected = entrada.replace("Semestre ","").split(" - ");
            String semestre = semestreSelected[0];
            String anno = semestreSelected[1];
            String query = "{ CALL spGet_Matricula_vs_AbandonoTotal(?,?)}";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(anno));
            ps.setInt(2, Integer.parseInt(semestre));
            ResultSet resultSet = ps.executeQuery();
            JSONObject respuesta = new JSONObject();
            while (resultSet.next()){
                int activos = resultSet.getInt("Total");
                int abandonos = resultSet.getInt("AbandonoTotal");
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
            String query = "{ CALL spGet_Matricula_Por_Genero(?,?)}";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(anno));
            ps.setInt(2, Integer.parseInt(semestre));
            ResultSet resultSet = ps.executeQuery();
            ResultSet rs = ps.executeQuery();
            List<List<String>> csv = resultSetToList(rs);
            writeCsv(csv, ',', out, true, "Tecnologico de Costa Rica\nMatricula por genero\n"+entrada);
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
            String query = "{ CALL spGet_Matricula_Vs_Abandono(?,?)}";
            CallableStatement ps = connection.prepareCall(query);
            ps.setInt(1, Integer.parseInt(anno));
            ps.setInt(2, Integer.parseInt(semestre));
            ResultSet rs = ps.executeQuery();
            List<List<String>> csv = resultSetToList(rs);
            writeCsv(csv, ',', out, true, "Tecnologico de Costa Rica\nMatricula vs abandonos\n"+entrada);
            return;
        }

    }
}
