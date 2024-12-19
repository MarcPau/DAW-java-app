<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Llibreria</title>
    <!-- Enlace a Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container my-4">
        <h1 class="text-center mb-4">Llibreria - Resultats de la consulta</h1>

        <!-- Botón para añadir un nuevo libro -->
        <div class="mb-3">
            <a href="insertar.html" class="btn btn-success">Añadir Nuevo Libro</a>
        </div>

        <!-- Tabla de resultados -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark text-uppercase text-center">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Títol</th>
                        <th scope="col">ISBN</th>
                        <th scope="col">Any de Publicació</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        /**
                         * Código dinámico para consultar y mostrar los resultados de la tabla "llibres".
                         * <p>
                         * Este bloque de código:
                         * <ul>
                         *   <li>Carga las propiedades de la base de datos desde el archivo {@code db.properties}.</li>
                         *   <li>Establece una conexión con la base de datos utilizando {@code DriverManager}.</li>
                         *   <li>Ejecuta una consulta SQL para recuperar todos los registros de la tabla "llibres".</li>
                         *   <li>Muestra los resultados en una tabla HTML.</li>
                         * </ul>
                         * </p>
                         *
                         * @note Manejo de errores: Si ocurre un error, se muestra un mensaje en la tabla y se imprime la traza.
                         * @note Recursos: La conexión, el statement y el resultSet se cierran en el bloque finally para evitar fugas de recursos.
                         */
                        Connection connection = null;
                        PreparedStatement statement = null;
                        ResultSet resultSet = null;
                        try {
                            // Cargar propiedades de la base de datos
                            Properties properties = new Properties();
                            properties.load(getServletContext().getResourceAsStream("/WEB-INF/classes/db.properties"));

                            String url = properties.getProperty("db.url");
                            String username = properties.getProperty("db.username");
                            String password = properties.getProperty("db.password");

                            // Conectar a la base de datos
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connection = DriverManager.getConnection(url, username, password);

                            // Ejecutar consulta
                            String query = "SELECT id, titol, isbn, any_publicacio FROM llibres";
                            statement = connection.prepareStatement(query);
                            resultSet = statement.executeQuery();

                            // Mostrar resultados en la tabla
                            while (resultSet.next()) {
                                int id = resultSet.getInt("id");
                                String titol = resultSet.getString("titol");
                                String isbn = resultSet.getString("isbn");
                                int any = resultSet.getInt("any_publicacio");
                    %>
                    <tr>
                        <td class="text-center"><%= id %></td>
                        <td><%= titol %></td>
                        <td><%= isbn %></td>
                        <td class="text-center"><%= any %></td>
                        <td class="text-center">
                            <a href="modificar.html?id=<%= id %>" class="btn btn-warning btn-sm">Modificar</a>
                            <a href="eliminar.jsp?id=<%= id %>" class="btn btn-danger btn-sm">Eliminar</a>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            /**
                             * Manejo de errores:
                             * Si ocurre un error durante la conexión o ejecución de la consulta, muestra el mensaje de error
                             * dentro de la tabla y registra el error en el servidor.
                             */
                            out.println("<tr><td colspan='5' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            e.printStackTrace();
                        } finally {
                            // Cerrar recursos para evitar fugas
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Enlace a Bootstrap 5 JS (opcional) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
