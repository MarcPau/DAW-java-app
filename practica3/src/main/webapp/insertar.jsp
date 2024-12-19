<%@ page import="java.sql.*" %>
<%@ page import="com.web.Connexio" %>
<%@ page import="java.util.*" %>

/**
 * Página JSP para insertar un nuevo libro en la base de datos.
 * <p>
 * Esta página procesa una solicitud HTTP que incluye parámetros de un nuevo libro y los inserta en la tabla {@code llibres}.
 * </p>
 *
 * <h3>Funcionamiento:</h3>
 * <ul>
 *     <li>Recibe parámetros HTTP: {@code titol}, {@code isbn}, {@code any_publicacio}, {@code id_editorial}.</li>
 *     <li>Convierte los valores necesarios a tipos adecuados, como {@code int} para {@code any_publicacio} e {@code id_editorial}.</li>
 *     <li>Conecta a la base de datos utilizando la clase {@link com.web.Connexio}.</li>
 *     <li>Ejecuta una sentencia SQL de tipo INSERT para agregar el nuevo registro.</li>
 *     <li>Muestra un mensaje de éxito o error en función del resultado de la operación.</li>
 * </ul>
 *
 * <h3>Manejo de errores:</h3>
 * <ul>
 *     <li>Si faltan parámetros, muestra un mensaje indicando que se deben completar todos los campos.</li>
 *     <li>Si ocurre un error al conectar o ejecutar la sentencia SQL, muestra el mensaje del error.</li>
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
