package com.vinculacion.pamtec.sisasServlets;

import com.google.protos.cloud.sql.Sql;
import com.vinculacion.pamtec.BaseServlet;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.SQLType;
import java.sql.Types;
import java.util.ArrayList;

@WebServlet(name = "SaveListaAsistencia", value = "/saveListaAsistencia")
public class SaveListaAsistenciaServlet extends BaseServlet {

    private ArrayList<Asistente> listaAsistentes;
    private ArrayList<EstudiantePam> listaEstudiantes;

    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        String curso = "";
        try {
            listaAsistentes = new ArrayList<>();
            listaEstudiantes = new ArrayList<>();
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iterator = upload.getItemIterator(req);
            while (iterator.hasNext()) {
                FileItemStream item = iterator.next();
                InputStream stream = item.openStream();
                if (item.isFormField()) {
                    String idForm = item.getFieldName();
                    if (idForm.equals("curso")) {
                        curso = Streams.asString(stream, "UTF-8");
                        out.print(curso);
                    } else if (idForm.startsWith("radio-")) {
                        String id = idForm.replace("radio-", "");
                        String valor = Streams.asString(stream, "UTF-8");

                        EstudiantePam r = listaEstudiantes.get(getEstudiante(id));
                        r.estado = valor;
                    } else if (idForm.startsWith("radioAsis-")) {
                        String id = idForm.replace("radioAsis-", "");
                        String valor = Streams.asString(stream, "UTF-8");

                        Asistente r = listaAsistentes.get(getAsistente(id));
                        r.estado = valor;
                    } else if (idForm.startsWith("justEst")) {
                        String id = idForm.replace("justEst", "");
                        String valor = Streams.asString(stream, "UTF-8");
                        EstudiantePam r = listaEstudiantes.get(getEstudiante(id));
                        r.justificacion = valor;
                    } else if (idForm.startsWith("justAsi")) {
                        String id = idForm.replace("justAsi", "");
                        String valor = Streams.asString(stream, "UTF-8");
                        Asistente r = listaAsistentes.get(getAsistente(id));
                        r.justificacion = valor;
                    }

                } else {


                }
            }
        } catch (Exception ex) {
            saveError(ex, "SaveListaAsistencia");
            HttpSession session = req.getSession(true);
            session.setAttribute("message", "Hubo un error con la peticion.");
            resp.sendRedirect(req.getHeader("referer"));
            return;
        }

        for (EstudiantePam e : listaEstudiantes){
            int estado = 1;
            if (e.estado.equals("Ausente")){
                estado = 2;
            } else {
                estado = 3;
            }


            PreparedStatement ps = connection.prepareStatement("{call spAsistencia_Estudiante_PAM_setAsistencia(?,?,?,?)}");
            ps.setInt(1, Integer.parseInt(curso));
            ps.setInt(2, Integer.parseInt(e.cedula));
            ps.setInt(3, estado);
            if (estado == 3 && e.justificacion != null){
                ps.setString(4, e.justificacion);
            } else {
                ps.setNull(4, Types.VARCHAR);
            }

            executeOperation(ps);
        }

        for (Asistente e : listaAsistentes){
            int estado = 1;
            if (e.estado.equals("Ausente")){
                estado = 2;
            } else {
                estado = 3;
            }

            PreparedStatement ps = connection.prepareStatement("{call spAsistencia_Asistente_setAsistencia(?,?,?,?)}");
            ps.setInt(1, Integer.parseInt(curso));
            ps.setInt(2, Integer.parseInt(e.cedula));
            ps.setInt(3, estado);
            if (estado == 3 && e.justificacion != null){
                ps.setString(4, e.justificacion);
            } else {
                ps.setNull(4, Types.VARCHAR);
            }

            executeOperation(ps);
        }
        HttpSession session = req.getSession(true);
        session.setAttribute("message", "La lista de asistencia se ha guardado con exito.");
        resp.sendRedirect("/SISAS/profesor/");




    }



    private class EstudiantePam {
        String cedula;
        String estado;
        String justificacion;
    }

    private class Asistente {
        String cedula;
        String estado;
        String justificacion;
    }

    private int getEstudiante(String cedula) {
        for (EstudiantePam i : listaEstudiantes) {
            if (i.cedula.equals(cedula)) {
                return listaEstudiantes.indexOf(i);
            }
        }
        EstudiantePam nuevo = new EstudiantePam();
        nuevo.cedula = cedula;
        listaEstudiantes.add(nuevo);
        return listaEstudiantes.indexOf(nuevo);
    }

    private int getAsistente(String cedula) {
        for (Asistente i : listaAsistentes) {
            if (i.cedula.equals(cedula)) {
                return listaAsistentes.indexOf(i);
            }
        }
        Asistente nuevo = new Asistente();
        nuevo.cedula = cedula;
        listaAsistentes.add(nuevo);
        return listaAsistentes.indexOf(nuevo);
    }


}
