<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>

<%
    // Obtener parámetros del formulario
    String idParam = request.getParameter("id");
    String titol = request.getParameter("titol");
    String isbn = request.getParameter("isbn");
    String anyPublicacioParam = request.getParameter("any_publicacio");
    String idEditorialParam = request.getParameter("id_editorial");

    try {
        // Validar que los parámetros no sean nulos o vacíos
        if (idParam != null && !idParam.isEmpty() &&
            titol != null && !titol.isEmpty() &&
            isbn != null && !isbn.isEmpty() &&
            anyPublicacioParam != null && !anyPublicacioParam.isEmpty() &&
            idEditorialParam != null && !idEditorialParam.isEmpty()) {

            // Convertir parámetros numéricos
            int id = Integer.parseInt(idParam);
            int anyPublicacio = Integer.parseInt(anyPublicacioParam);
            int idEditorial = Integer.parseInt(idEditorialParam);

            // Conexión a la base de datos y actualización del registro
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = Connexio.getConnexio()) {
                String sql = "UPDATE llibres SET titol = ?, isbn = ?, any_publicacio = ?, id_editorial = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, titol);
                    stmt.setString(2, isbn);
                    stmt.setInt(3, anyPublicacio);
                    stmt.setInt(4, idEditorial);
                    stmt.setInt(5, id);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<h1 class='text-success'>Libro modificado correctamente</h1>");
                        response.setHeader("Refresh", "5; URL=llibreria.jsp");
                    } else {
                        out.println("<h1 class='text-warning'>No se encontró un libro con el ID proporcionado</h1>");
                    }
                }
            } catch (SQLException e) {
                out.println("<h1 class='text-danger'>Error al modificar el libro: " + e.getMessage() + "</h1>");
                e.printStackTrace();
            }
        } else {
            out.println("<h1 class='text-danger'>Por favor, completa todos los campos.</h1>");
        }
    } catch (Exception e) {
        out.println("<h1 class='text-danger'>Error inesperado: " + e.getMessage() + "</h1>");
        e.printStackTrace();
    }
%>
