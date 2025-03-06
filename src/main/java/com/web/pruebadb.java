package com.web;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * Clase para probar la conexión a una base de datos utilizando un archivo de propiedades.
 * <p>
 * La clase carga las configuraciones desde un archivo {@code db.properties} ubicado en el directorio 
 * {@code src/main/resources} y establece la conexión con la base de datos utilizando el driver JDBC configurado.
 * </p>
 * 
 * @author Marc Corcoles Valle
 */
public class pruebadb {

    /**
     * Obtiene una conexión a la base de datos utilizando las propiedades definidas en el archivo 
     * {@code db.properties}.
     *
     * @return una instancia de {@link Connection} para interactuar con la base de datos.
     * @throws Exception si ocurre un error al cargar el archivo de propiedades, al cargar el driver JDBC 
     *                   o al establecer la conexión.
     */
    public static Connection getConnection() throws Exception {
        Properties properties = new Properties();
        
        // Cargar el archivo db.properties desde src/main/resources
        try (InputStream input = pruebadb.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new Exception("No se encontró el archivo db.properties");
            }
            properties.load(input);
        }

        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");
        String driver = properties.getProperty("db.driver");

        // Cargar el driver JDBC
        Class.forName(driver);

        // Retornar la conexión
        return DriverManager.getConnection(url, username, password);
    }

    /**
     * Método principal para probar la conexión a la base de datos.
     * <p>
     * Este método intenta establecer una conexión con la base de datos y verifica si la conexión fue 
     * exitosa. Si ocurre algún error, se imprime la traza del error.
     * </p>
     *
     * @param args argumentos de la línea de comandos (no utilizados).
     */
    public static void main(String[] args) {
        try (Connection connection = pruebadb.getConnection()) {
            if (connection != null) {
                System.out.println("Conexión exitosa a la base de datos MySQL.");
            } else {
                System.out.println("No se pudo establecer la conexión.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
