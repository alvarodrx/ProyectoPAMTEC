package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Calendar;

@WebServlet(name = "WebLogin", value = "/weblogin")
public class WebLoginServlet extends BaseServlet {
    
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();

        String tipo = req.getParameter("tipo");

        if (tipo!=null && tipo.equals("SALIR")){
            HttpSession session = req.getSession(true);
            session.setAttribute("errormessage", "");
            session.invalidate();
            req.setAttribute("errormessage", "");
            resp.sendRedirect("/SISAS/login/");
            return;
        }

        String usuario = req.getParameter("username");
        String passw = req.getParameter("password");
        String device = "web";

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        
        if (usuario == null || usuario.isEmpty() || passw == null || passw.isEmpty()) {
            session.setAttribute("errormessage", "Usuario o contrase&ntilde;a incorrecta.");
            log(usuario, passw, device, "INVALIDO");
            resp.sendRedirect("/SISAS/login/");
        }
        
        String query = "SELECT PK_Usuarios AS ID, FK_Tipos_Usuarios AS Tipo, Permiso_Acceso AS ESTADO, Nombre_Usuario AS NOMBRE FROM Usuarios WHERE Nombre_Usuario = '" + usuario + "' AND Contrasenna = '" + passw + "';";
        ResultSet rs = executeQuery(query);
        if (rs.next()){
            String userId = rs.getString("ID");
            if (rs.getInt("ESTADO") != 1){
                session.setAttribute("errormessage", "Esta cuenta se encuentra inactiva.");
                log(usuario, passw, device, "CUENTA INACTIVA");
                resp.sendRedirect("/SISAS/login/");
                return;
            } else {
                int userType = rs.getInt("Tipo");
                session.setAttribute("userId", rs.getString("ID"));
                session.setAttribute("usuario", rs.getString("NOMBRE"));
                session.setAttribute("tipoUsuario", userType);
                if (userType == 1) {
                    session.setAttribute("millis", Calendar.getInstance().getTimeInMillis());
                    session.setMaxInactiveInterval(3600);
                    resp.sendRedirect("/SISAS/administrador/");
                } else if (userType > 1){
                    query = "SELECT FK_Usuario_Id AS ID FROM Roles_Grupo WHERE FK_Usuario_Id = " + userId + ";";
                    ResultSet rs2 = executeQuery(query);
                    if (rs2.next()){
                        session.setAttribute("millis", Calendar.getInstance().getTimeInMillis());
                        session.setMaxInactiveInterval(3600);
                        resp.sendRedirect("/SISAS/profesor/misCursos.jsp");
                        log(usuario, passw, device, "VALIDO");
                        return;
                    }
                    session.setAttribute("errormessage", "Esta cuenta no tiene acceso al sistema.");
                    log(usuario, passw, device, "CUENTA INACTIVA");
                    resp.sendRedirect("/SISAS/login/");
                }
                return;
            }
        } else {
            session.setAttribute("errormessage", "Contrase&ntilde;a o cuenta incorrecta.");
            log(usuario, passw, device, "INVALIDO");
            resp.sendRedirect("/SISAS/login/");
        }
    }

    private void log(String usuario, String passw, String device, String result) {
        String insert = "INSERT INTO Log_Login(Usuario, Passw, Device, Result) VALUES (?, ?, ?, ?);";
        try {
            PreparedStatement stmt = connection.prepareStatement(insert);
            stmt.setString(1, usuario);
            stmt.setString(2, passw);
            stmt.setString(3, device);
            stmt.setString(4, result);
            executeOperation(stmt);
        } catch(Exception ex) {
            saveError(ex, "login");
        }
    }
}

