package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

@WebServlet(name = "SavePermisosAsistentes", value = "/savePermisosAsistentes")
public class SavePermisosAsistentesServlet extends BaseServlet {
    private ArrayList<Asistente> listaAsistentes;
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {

        String query = "{CALL spGet_Asistentes_Permisos() }";
        CallableStatement ps = connection.prepareCall(query);
        ResultSet rs = ps.executeQuery();

        listaAsistentes = new ArrayList<>();

        while (rs.next()) { //Agrega los asistentes a la lista
            String grupoID = rs.getString("FK_Grupos");
            String cedula = rs.getString("FK_Asitente_Id");
            setAsistenteLista(cedula, false, grupoID); //nos evitamos
        }

        PrintWriter out = resp.getWriter();

        try {

            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iterator = upload.getItemIterator(req);
            while (iterator.hasNext()) {
                FileItemStream item = iterator.next();
                InputStream stream = item.openStream();
                if (item.isFormField()) {
                    String idForm = item.getFieldName();
                    if (idForm.startsWith("check-")) {
                        String[] arrOfStr = idForm.split("-",5);
                        String idGrupo = arrOfStr[1];
                        String idAsis = arrOfStr[2];
                        setAsistenteNuevoEstado(idAsis,idGrupo);
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

        for (Asistente a : listaAsistentes){

            PreparedStatement ps2 = connection.prepareStatement("{call spSet_Asistentes_Permisos(?,?,?)}");
            ps2.setInt(1, Integer.parseInt(a.grupoID));
            ps2.setInt(2, Integer.parseInt(a.cedula));
            ps2.setBoolean(3, a.getEstado());

           executeOperation(ps2);
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("message", "Los permisos de acceso se han guardado con exito.");
        resp.sendRedirect("/SISAS/administrador/");


    }

    private class Asistente {
        String cedula;
        private Boolean estado;
        String grupoID;

        public Asistente(String cedula, Boolean estado, String grupoID) {
            this.cedula = cedula;
            this.estado = estado;
            this.grupoID = grupoID;
        }

        public Boolean getEstado(){
            return estado;
        }
    }


    private void setAsistenteNuevoEstado(String cedula,String grupo) { //actualiza el nuevo estado
        for (Asistente i : listaAsistentes) {
            if (i.cedula.equals(cedula) && i.grupoID.equals(grupo)) {
                i.estado = true; //Si se encuentra en la lista,
            }
        }
    }

    //Agrega un nuevo asistente a la lista
    private void setAsistenteLista(String cedula, Boolean estado, String grupoID){
        Asistente nuevo = new Asistente(cedula, estado, grupoID);
        listaAsistentes.add(nuevo);
    }
}


