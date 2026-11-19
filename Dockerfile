FROM maven:3.9-eclipse-temurin-11 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk11-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/ProductosPerecibles-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ProductosPerecibles.war

# La dirección principal de Render redirige al login de la aplicación.
RUN mkdir -p /usr/local/tomcat/webapps/ROOT \
    && printf '%s\n' \
    '<!DOCTYPE html>' \
    '<html lang="es">' \
    '<head>' \
    '<meta charset="UTF-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1.0">' \
    '<meta http-equiv="refresh" content="0; url=/ProductosPerecibles/login.jsp">' \
    '<title>Productos Perecibles</title>' \
    '</head>' \
    '<body>' \
    '<p>Redirigiendo al inicio de sesión...</p>' \
    '<a href="/ProductosPerecibles/login.jsp">Ir al inicio de sesión</a>' \
    '</body>' \
    '</html>' > /usr/local/tomcat/webapps/ROOT/index.html

EXPOSE 10000

CMD ["sh", "-c", "sed -i 's/port=\"8080\"/port=\"'\"${PORT:-10000}\"'\"/' /usr/local/tomcat/conf/server.xml && catalina.sh run"]
