# Stage 1: build
FROM maven:3.9.3-eclipse-temurin-17 AS build

WORKDIR /app

# Copia il POM padre e i moduli
COPY pom.xml ./
COPY auth-service/pom.xml ./auth-service/pom.xml
COPY learn-service/pom.xml ./learn-service/pom.xml
COPY payment-service/pom.xml ./payment-service/pom.xml

# Ora copia i sorgenti
COPY auth-service/src ./auth-service/src
COPY learn-service/src ./learn-service/src
COPY payment-service/src ./payment-service/src
# Installa il parent POM e risolve dipendenze offline
RUN mvn install -DskipTests


# Build del JAR
RUN mvn package -DskipTests

# Stage 2: runtime
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY --from=build /app/learn-service/target/learn-service-1.0.0.jar ./learn-service.jar

ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "learn-service.jar"]