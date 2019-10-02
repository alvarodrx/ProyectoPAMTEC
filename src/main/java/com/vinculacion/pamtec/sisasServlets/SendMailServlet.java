package com.vinculacion.pamtec.sisasServlets;

import com.vinculacion.pamtec.BaseServlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet("/sendMail")
public class SendMailServlet extends BaseServlet {
    @Override
    public void doRequest(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        PrintWriter out = resp.getWriter();
        String message = req.getParameter("message");
        String subject = req.getParameter("subject");
        String recipient = req.getParameter("recipient");
        String tipo = req.getParameter("tipo");

        if (tipo != null && tipo.equals("utf8")){
            sendMail(recipient, subject, message, out);
        } else if (tipo != null && tipo.equals("html")){
            sendHtmlMail(recipient, subject, message, out);
        }


        out.print("Subject: "+subject);
        out.print("<br>");
        out.print("Mensaje: "+message);
        out.print("<br>");
        out.print("A: "+recipient);



        out.print("Enviado...");
    }
}
