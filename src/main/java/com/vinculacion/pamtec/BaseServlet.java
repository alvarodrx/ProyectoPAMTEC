package com.vinculacion.pamtec;

import org.apache.commons.lang3.StringEscapeUtils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public abstract class BaseServlet extends HttpServlet {
    
    private static final long MAX_SESSION = 3600000; //3,600,000 1h
    
    private static final String SENDER = "dev.vinculacion.itcr@gmail.com";
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
        String url = "jdbc:google:mysql://pamtec-itcr:us-east4:pamtec/pruebas";
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

    protected boolean sendMail(String to, String titulo, String texto, PrintWriter out) throws Exception {

        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);
        String msgBody = texto;

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SENDER));
            InternetAddress[] address = InternetAddress.parse(to, true);
            //Setting the recepients from the address variable
            msg.setRecipients(Message.RecipientType.TO, address);
//            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(RECIPIENT));
            msg.setSubject(titulo, "UTF-8");
            msg.setText(msgBody, "UTF-8");
            Transport.send(msg);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    protected boolean sendHtmlMail(String to, String titulo, String htmlText, PrintWriter out) throws Exception {

        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SENDER));
            InternetAddress[] address = InternetAddress.parse(to, true);
            //Setting the recepients from the address variable
            msg.setRecipients(Message.RecipientType.TO, address);
//            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(RECIPIENT));
            msg.setSubject(titulo, "UTF-8");
            MimeMultipart multipart = new MimeMultipart("related");

            // first part (the html)
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(htmlText, "text/html");
            // add it
            multipart.addBodyPart(messageBodyPart);
            msg.setContent(multipart);
            Transport.send(msg);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    protected boolean sendMail(String mail1, String mailCC, String titulo, String texto, PrintWriter out) throws Exception {

        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);
        String msgBody = texto;

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SENDER));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mail1));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(mailCC));
//            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(RECIPIENT));
            msg.setSubject(titulo, "UTF-8");
            msg.setText(msgBody, "UTF-8");
            Transport.send(msg);
        } catch (Exception e) {
            return false;
        }

        return true;
    }

    protected static <T> void writeCsv(List<List<T>> csv, char separator, PrintWriter writer, boolean finish, String etiqueta) throws IOException {
        writer.append(etiqueta);
        writer.append(separator);
        writer.println("");

        for (List<T> row : csv) {
            for (Iterator<T> iter = row.iterator(); iter.hasNext(); ) {
                String field = String.valueOf(iter.next()).replace("\"", "\"\"");
                if (field.indexOf(separator) > -1 || field.indexOf('"') > -1) {
                    field = '"' + field + '"';
                }
                writer.append(field);
                if (iter.hasNext() || !finish) {
                    writer.append(separator);
                }
            }
            writer.println("");
        }
        if (finish)
            writer.flush();
        else {
            writer.append("");
            writer.append(separator);
            writer.println("");
        }

    }


    protected List<List<String>> resultSetToList(ResultSet rs) throws SQLException {
        ResultSetMetaData md = rs.getMetaData();
        int columns = md.getColumnCount();
        List<List<String>> rows = new ArrayList<List<String>>();
        List<String> firstRow = new ArrayList<String>(columns);
        for (int i = 1; i <= columns; ++i) {
            firstRow.add(md.getColumnLabel(i));
        }
        rows.add(firstRow);
        while (rs.next()) {
            List<String> row = new ArrayList<String>(columns);
            for (int i = 1; i <= columns; ++i) {
                if (rs.getObject(i) != null)
                    row.add(rs.getObject(i).toString());
                else
                    row.add("");
            }
            rows.add(row);
        }
        return rows;
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

