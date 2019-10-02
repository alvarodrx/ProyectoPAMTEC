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
            message = "<p>Buen d&iacute;a Luis Mora, el siguiente reporte corresponde a estudiantes que se han ausentado en m&aacute;s de 2 lecciones hasta la fecha en el curso <b>Actualizacion</b> y el grupo <b>1</b>:</p>\n" +
                    "\n" +
                    "<table class=\"table\">\n" +
                    "    <thead>\n" +
                    "    <tr>\n" +
                    "        <th scope=\"col\">Cedula</th>\n" +
                    "        <th scope=\"col\">Estudiante</th>\n" +
                    "        <th scope=\"col\">Telefono</th>\n" +
                    "        <th scope=\"col\">Correo</th>\n" +
                    "    </tr>\n" +
                    "    </thead>\n" +
                    "    <tbody>\n" +
                    "    <tr>\n" +
                    "        <th scope=\"row\">101111117</th>\n" +
                    "        <td>Beatriz Pinzon</td>\n" +
                    "        <td>88992020</td>\n" +
                    "        <td>betty@gmail.com</td>\n" +
                    "    </tr>\n" +
                    "    <tr>\n" +
                    "        <th scope=\"row\">101111118</th>\n" +
                    "        <td>Antonio Garcia</td>\n" +
                    "        <td>88992021</td>\n" +
                    "        <td>antgar@gmail.com</td>\n" +
                    "    </tr>\n" +
                    "    <tr>\n" +
                    "        <th scope=\"row\">101111181</th>\n" +
                    "        <td>Maria Martinez</td>\n" +
                    "        <td>88992022</td>\n" +
                    "        <td>marti@gmail.com</td>\n" +
                    "    </tr>\n" +
                    "    </tbody>\n" +
                    "</table>";
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
