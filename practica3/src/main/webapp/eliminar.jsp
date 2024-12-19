<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>

/**
 * Página JSP para eliminar un libro de la base de datos.
 * <p>
 * Esta página procesa una solicitud de eliminación basada en el parámetro {@code id} recibido
 * desde la solicitud HTTP. Si el ID es válido y existe en la base de datos, se elimina el registro correspondiente.
 * </p>
 *
 * <h3>Funcionamiento:</h3>
 * <ul>
 *     <li>Recibe un parámetro {@code id} a través de la solicitud.</li>
 *     <li>Conecta a la base de datos utilizando la clase {@link com.web.Connexio}.</li>
 *     <li>Ejecuta una sentencia SQL para eliminar el registro cuyo ID coincide.</li>
 *     <li>Muestra un mensaje de éxito o error en función del resultado.</li>
 * </ul>
 *
 * <h3>Manejo de errores:</h3>
 * <ul>
 *     <li>Si no se proporciona un ID válido, muestra un mensaje indicando que es necesario.</li>
 *     <li>Si ocurre un error durante la conexión o la ejecución de la sentencia SQL, muestra el mensaje de error correspondiente.</li>
 * </ul>
 *
 * <h3>Redirección:</h3>
 * <ul>
 *     <li>En caso de éxito, la página redirige automáticamente a {@code llibreria.jsp} después de 5 segundos.</li>
 * </ul>
 *
 * @note Esta página requiere el driver JDBC para MySQL ({@code com.mysql.cj.jdbc.Driver}) y una configuración válida de conexión.
 */
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
