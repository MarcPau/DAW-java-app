<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>
<%@ page import="java.util.*" %>

<%
    String titol = request.getParameter("titol");
    String isbn = request.getParameter("isbn");
    String anyPublicacioParam = request.getParameter("any_publicacio");
    String idEditorialParam = request.getParameter("id_editorial");
    Class.forName("com.mysql.cj.jdbc.Driver");

    if (titol != null && isbn != null && anyPublicacioParam != null && idEditorialParam != null) {
        int anyPublicacio = Integer.parseInt(anyPublicacioParam);
        int idEditorial = Integer.parseInt(idEditorialParam);

        try (Connection conn = Connexio.getConnexio()) {
            String sql = "INSERT INTO llibres (titol, isbn, any_publicacio, id_editorial) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, titol);
                stmt.setString(2, isbn);
                stmt.setInt(3, anyPublicacio);
                stmt.setInt(4, idEditorial);
                stmt.executeUpdate();
                out.println("<h1>Libro insertado correctamente</h1>");
                response.setHeader("Refresh", "5; URL=llibreria.jsp");
            }
        } catch (Exception e) {
            out.println("<h1>Error al insertar el libro: " + e.getMessage() + "</h1>");
        }
    } else {
        out.println("<h1>Por favor, completa todos los campos.</h1>");
    }
%>