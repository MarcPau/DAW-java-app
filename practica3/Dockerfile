# Usar la imagen oficial de WildFly 34
FROM jboss/wildfly:34.0.1.Final

# Copiar el archivo WAR en la carpeta de despliegue de WildFly
COPY target/llibreria.war /opt/jboss/wildfly/standalone/deployments/

# Exponer el puerto 8080 para acceder a la aplicación
EXPOSE 8084

# Comando para iniciar WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
