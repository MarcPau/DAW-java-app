<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>

/**
 * Página JSP para modificar un registro de la tabla "llibres" en la base de datos.
 * <p>
 * Esta página recibe parámetros del formulario enviados mediante la solicitud HTTP,
 * valida los datos y actualiza el registro correspondiente en la base de datos.
 * </p>
 *
 * <h3>Funcionamiento:</h3>
 * <ul>
 *     <li>Recibe los parámetros {@code id}, {@code titol}, {@code isbn}, {@code any_publicacio}, {@code id_editorial}.</li>
 *     <li>Valida que los parámetros no sean nulos o vacíos.</li>
 *     <li>Convierte los valores necesarios a tipos adecuados, como {@code int} para {@code id}, {@code any_publicacio} y {@code id_editorial}.</li>
 *     <li>Conecta a la base de datos utilizando la clase {@link com.web.Connexio}.</li>
 *     <li>Ejecuta una sentencia SQL de tipo UPDATE para modificar el registro con el ID especificado.</li>
 *     <li>Muestra mensajes de éxito o error en función del resultado de la operación.</li>
 * </ul>
 *
 * <h3>Manejo de errores:</h3>
 * <ul>
 *     <li>Si faltan parámetros, muestra un mensaje indicando que se deben completar todos los campos.</li>
 *     <li>Si ocurre un error al conectar o ejecutar la sentencia SQL, muestra el mensaje del error.</li>
 *     <li>Captura excepciones inesperadas y las muestra en la salida.</li>
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
