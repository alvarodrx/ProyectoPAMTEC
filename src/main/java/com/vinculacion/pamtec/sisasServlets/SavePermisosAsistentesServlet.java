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

@WebServlet(name = "SavePermisosAsistentes", value = "/savePermisosAsistentes")
public class SavePermisosAsistentesServlet extends BaseServlet {
    private ArrayList<Asistente> listaAsistentes;
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
/*
        try {
            listaAsistentes = new ArrayList<>();
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iterator = upload.getItemIterator(req);
            while (iterator.hasNext()) {
                FileItemStream item = iterator.next();
                InputStream stream = item.openStream();
                if (item.isFormField()) {
                    String idForm = item.getFieldName();
                    if (idForm.startsWith("chek-")) {
                        String[] arrOfStr = idForm.split("-",5);
                        String idAsis = arrOfStr[1];
                        String idGrupo = arrOfStr[2];
                        SavePermisosAsistentesServlet.Asistente r = listaAsistentes.get(getAsistente(idAsis));
                        r.grupoID = idGrupo;
                        //Aqui debe de ir la parte de ver si está seleccionado o no
                    }
                }
            }
        } catch (Exception ex) {
            saveError(ex, "SavePermisosAsistentes");
            HttpSession session = req.getSession(true);
            session.setAttribute("message", "Hubo un error con la peticion.");
            resp.sendRedirect(req.getHeader("referer"));
            return;
        }

        //for (Asistente a : listaAsistentes){

        //    PreparedStatement ps = connection.prepareStatement("{call spSet_Asistentes_Permisos(?,?,?)}");
        //    ps.setInt(1, Integer.parseInt(a.grupoID));
        //    ps.setInt(2, Integer.parseInt(a.cedula));
        //    ps.setBoolean(3, a.getEstado());

        //    executeOperation(ps);
        //}
*/
        HttpSession session = req.getSession(true);
        session.setAttribute("message", "Los permisos de acceso se han guardado con exito.");
        resp.sendRedirect("/SISAS/administrador/");


    }

    private class Asistente {
        String cedula;
        private Boolean estado;
        String grupoID;
        public void setEstado(Boolean estado){
            if(estado == null){
                estado = false;
            }else{
                this.estado = estado;
            }

        }
        public Boolean getEstado(){
            return estado;
        }
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


