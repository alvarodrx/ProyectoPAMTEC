package com.vinculacion.pamtec.sisasServlets;

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
import java.util.ArrayList;

@WebServlet(name = "SaveNotasCursoAdmi", value = "/saveNotasCursoAdmi")
public class SaveNotasCursoAdmiServlet extends BaseServlet {

    private ArrayList<EstudiantePam> listaEstudiantes;

    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        String curso = "";
        try {
            listaEstudiantes = new ArrayList<>();
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iterator = upload.getItemIterator(req);
            while (iterator.hasNext()) {
                FileItemStream item = iterator.next();
                InputStream stream = item.openStream();
                if (item.isFormField()) {
                    String idForm = item.getFieldName();
                    if (idForm.equals("groupS")) {
                        curso = Streams.asString(stream, "UTF-8");
                        String curso2 = req.getParameter("gruposSelect");
                        out.print("Este es el grupo uno: "+curso);
                        out.print("Este es el grupo dos: "+curso2);
                    } else if (idForm.startsWith("nota-")) {
                        String id = idForm.replace("nota-", "");
                        String valor = Streams.asString(stream, "UTF-8");

                        EstudiantePam r = listaEstudiantes.get(getEstudiante(id));
                        r.nota = Float.valueOf(valor);
                        out.println(r.nota);
                    }

                } else {


                }
            }
        } catch (Exception ex) {
            saveError(ex, "SaveNotasCurso");
            HttpSession session = req.getSession(true);
            session.setAttribute("message", "Hubo un error con la peticion.");
            resp.sendRedirect(req.getHeader("referer"));
            return;
        }

        for (EstudiantePam e : listaEstudiantes){

            PreparedStatement ps = connection.prepareStatement("{call spEstudiantes_PAM_Grupo_SetNota(?,?,?)}");
            //ps.setInt(1, Integer.parseInt(curso));
            //ps.setInt(2, Integer.parseInt(e.cedula));
            //ps.setFloat(3, e.nota);

            //executeOperation(ps);
        }


        HttpSession session = req.getSession(true);
        session.setAttribute("message", "Las notas del curso se han guardado con exito.");
        //resp.sendRedirect("/SISAS/administrador/");




    }



    private class EstudiantePam {
        String cedula;
        String estado;
        String justificacion;
        float nota;
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

}
