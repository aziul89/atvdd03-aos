# Etapa de build
FROM maven:3.8.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .        # Copia o arquivo pom.xml para o container
COPY src ./src        # Copia o diretório src para o container
RUN mvn clean package -DskipTests  # Executa o Maven para compilar e empacotar a aplicação

# Etapa de runtime
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar  # Copia o arquivo JAR gerado da etapa de build
EXPOSE 8080           # Expõe a porta 8080
ENTRYPOINT ["java", "-jar", "app.jar"]  # Comando para executar a aplicação
