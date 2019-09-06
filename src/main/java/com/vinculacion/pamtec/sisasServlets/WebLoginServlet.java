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
            session.invalidate();
            resp.sendRedirect("/");
            return;
        }

        String usuario = req.getParameter("username");
        String passw = req.getParameter("password");
        String device = "web";

        HttpSession session = req.getSession(true);
        session.removeAttribute("message");
        
        if (usuario == null || usuario.isEmpty() || passw == null || passw.isEmpty()) {
            session.setAttribute("message", "Usuario o contrase&ntilde;a incorrecta.");
            log(usuario, passw, device, "INVALIDO");
            resp.sendRedirect("/login/");
        }
        
        String query = "SELECT Id AS ID, Estado AS ESTADO FROM Usuario WHERE Usuario = '" + usuario + "' AND Password = '" + passw + "';";
        ResultSet rs = executeQuery(query);
        if (rs.next()){
            if (rs.getInt("ESTADO") != 1){
                session.setAttribute("message", "Esta cuenta se encuentra inactiva.");
                log(usuario, passw, device, "CUENTA INACTIVA");
                resp.sendRedirect("/login/");
                return;
            } else {
                session.setAttribute("userId", rs.getString("ID"));
                //session.setAttribute("usuario", rs.getString("NOMBRE"));
                session.setAttribute("millis", Calendar.getInstance().getTimeInMillis());
                session.setMaxInactiveInterval(3600);
                resp.sendRedirect("/");
                log(usuario, passw, device, "VALIDO");
                return;
            }
        } else {
            session.setAttribute("message", "Contrase&ntilde;a incorrecta.");
            log(usuario, passw, device, "INVALIDO");
            resp.sendRedirect("/login/");
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

