package com.web;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

/**
 * Clase que gestiona la conexión a una base de datos utilizando un archivo de propiedades.
 * <p>
 * Esta clase carga las credenciales de acceso y la URL de conexión desde un archivo llamado
 * {@code db.properties}, el cual debe estar ubicado en el classpath del proyecto.
 * </p>
 * @author Marc Corcoles Valle
 */
public class Connexio {

    /**
     * Nombre del archivo de propiedades que contiene los detalles de la conexión a la base de datos.
     */
    private static final String PROPERTIES_FILE = "db.properties";

    /**
     * Obtiene una conexión a la base de datos utilizando las credenciales y la URL especificadas en
     * el archivo de propiedades.
     *
     * @return una instancia de {@link Connection} para interactuar con la base de datos.
     * @throws Exception si ocurre un error al cargar el archivo de propiedades o al establecer la conexión.
     */
    public static Connection getConnexio() throws Exception {
        Properties properties = new Properties();

        // Cargar las propiedades desde db.properties
        try (InputStream input = Connexio.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new Exception("No se encontró el archivo db.properties");
            }
            properties.load(input);
        }

        // Obtener credenciales y URL
        String url = properties.getProperty("db.url");
        String username = properties.getProperty("db.username");
        String password = properties.getProperty("db.password");

        // Retornar la conexión
        return DriverManager.getConnection(url, username, password);
    }
}
