package com.vinculacion.pamtec;

import org.apache.commons.lang3.StringEscapeUtils;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Calendar;
import java.util.Locale;
import java.util.TimeZone;

public abstract class BaseServlet extends HttpServlet {
    
    private static final long MAX_SESSION = 3600000; //3,600,000 1h
    
    private static final String SENDER = "info@example.com";
    protected Connection connection;
    
    
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();
        try {
            startConnection();
            try {
                doRequest(req, resp);
            } catch (Exception ex) {
                saveError(ex, req.getRequestURL().toString());
                out.println(ex.toString());
            } finally {
                closeConnection();
            }
        } catch(Exception ex) {
            saveError(ex, req.getRequestURL().toString());
            out.println(ex.toString());
        }
    }
    
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        PrintWriter out = resp.getWriter();
        try {
            startConnection();
            try {
                doRequest(req, resp);
            } catch (Exception ex) {
                out.println(ex.toString());
                saveError(ex, req.getRequestURL().toString());
            } finally {
                closeConnection();
            }
        } catch(Exception ex) {
            out.println(ex.toString());
            saveError(ex, req.getRequestURL().toString());
        }
    }
    
    protected void saveError(Exception ex, String context) {
        try {
            String insert = "INSERT INTO Errores (Texto) VALUES (?);";
            PreparedStatement stmt = connection.prepareStatement(insert);
            String errorMsg = context + "  -  " +ex.toString();
            stmt.setString(1, errorMsg);
            executeOperation(stmt);
            
        } catch (Exception ex2) {
            
        }
    }
    
    protected void saveError(String errorMsg) {
        try {
            String insert = "INSERT INTO Errores (Texto) VALUES (?);";
            PreparedStatement stmt = connection.prepareStatement(insert);
            stmt.setString(1, errorMsg);
            executeOperation(stmt);
            
        } catch (Exception ex2) {
            
        }
    }
    
    public abstract void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception;
    
    // UTILITY METHODS
    
    private void startConnection() throws Exception {
        Class.forName("com.mysql.jdbc.GoogleDriver");
        String url = "jdbc:google:mysql://pamtec-itcr:us-east4c:pamtec/pamtec-db";
        connection = DriverManager.getConnection(url, "root","pamtec123");
    }
    
    private void closeConnection() throws IOException, SQLException {
        connection.close();
    }
    
    protected ResultSet executeQuery(String query) throws IOException, SQLException {
        return connection.createStatement().executeQuery(query);
    }
    
    protected boolean executeOperation(PreparedStatement stmt) throws IOException, SQLException {
        int success = 2;
        success = stmt.executeUpdate();
        return (success == 1);
    }
    
    protected String escapeString(String input) {
        if (input == null) {
            return "";
        }
        return StringEscapeUtils.escapeHtml4(input);
    }
    
    protected String checkNull(String value) {
        if (value == null || value.equals("null")) {
            return "";
        }
        return value;
    }
    
    protected boolean validateKey(String key, String user) throws Exception {
        try {
            long keyValue = Long.parseLong(key);
            long userValue = Long.parseLong(user);
            
            Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("GMT-6"), Locale.US);
            int day = cal.get(Calendar.DAY_OF_YEAR);
            
            return (userValue * day) == keyValue;
            
        } catch (Exception ex) {
            // Nothing to do
        }
        
        return false;
    }
    
    protected boolean sendMail(String mail1, String mail2, String titulo, String texto, PrintWriter out) throws Exception {
        
        try {
//            String insert = "INSERT INTO Emails (Mail1, Mail2, Titulo, Texto) VALUES (?, ?, ?, ?);";
//            PreparedStatement stmt = connection.prepareStatement(insert);
//            stmt.setString(1, mail1);
//            stmt.setString(2, mail2);
//            stmt.setString(3, titulo);
//            stmt.setString(4, texto);
//            executeOperation(stmt);
            
        } catch (Exception ex2) {
            
        }
        return true;
    }
    
    public boolean validateSession (HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        String userId = (String)session.getAttribute("userId");
        Long milis = (Long)session.getAttribute("millis");
        
        if (userId != null && !userId.isEmpty() && milis != null && milis > 0) {
            long currentMilis = Calendar.getInstance().getTimeInMillis();
            //saveError("TIMEOUT Current:"+ currentMilis  + " Milis:" + milis + " DIF:" + (currentMilis - milis));
            if ((currentMilis - milis) < MAX_SESSION) {
                session.setAttribute("millis", currentMilis);
                return true;
            }
        }
        return false;
    }

    
}

