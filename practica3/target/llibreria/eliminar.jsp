<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>

<%
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
         Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = Connexio.getConnexio()) {
            String sql = "DELETE FROM llibres WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<h1>Libro eliminado correctamente</h1>");
                    response.setHeader("Refresh", "5; URL=llibreria.jsp");
                } else {
                    out.println("<h1>No se encontró un libro con el ID proporcionado</h1>");
                }
            }
        } catch (Exception e) {
            out.println("<h1>Error al eliminar el libro: " + e.getMessage() + "</h1>");
            e.printStackTrace();
        }
    } else {
        out.println("<h1>Por favor, proporciona un ID válido.</h1>");
    }
%>
