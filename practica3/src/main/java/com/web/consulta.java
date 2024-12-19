package com.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet que maneja solicitudes HTTP GET para consultar datos de una base de datos.
 * <p>
 * Este servlet realiza una consulta SQL a una tabla llamada {@code llibres}, recupera los resultados y 
 * genera una respuesta en formato HTML para mostrarlos en un navegador web.
 * </p>
 * 
 * @author Marc Corcoles Valle
 */
public class consulta extends HttpServlet {

    /**
     * Maneja las solicitudes HTTP GET enviadas al servlet.
     * <p>
     * Realiza una consulta SQL para recuperar datos de la base de datos y genera una tabla en formato HTML
     * para mostrar los resultados al usuario.
     * </p>
     *
     * @param request  la solicitud HTTP recibida.
     * @param response la respuesta HTTP que se enviará al cliente.
     * @throws ServletException si ocurre un error relacionado con el servlet.
     * @throws IOException      si ocurre un error de entrada/salida durante la generación de la respuesta.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection connection = Connexio.getConnexio()) {
            // Consulta SQL (ejemplo)
            String query = "SELECT id, titol, isbn, any_publicacio FROM llibres";
            try (PreparedStatement statement = connection.prepareStatement(query);
                 ResultSet resultSet = statement.executeQuery()) {

                // Generar respuesta HTML
                out.println("<html><head><title>Consulta</title></head><body>");
                out.println("<h1>Resultats de la consulta</h1>");
                out.println("<table border='1'><tr><th>ID</th><th>Títol</th><th>Autor</th><th>Any</th></tr>");

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String titol = resultSet.getString("titol");
                    String isbn = resultSet.getString("isbn");
                    int any = resultSet.getInt("any_publicacio");

                    out.println("<tr><td>" + id + "</td><td>" + titol + "</td><td>" + isbn + "</td><td>" + any + "</td></tr>");
                }

                out.println("</table></body></html>");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
