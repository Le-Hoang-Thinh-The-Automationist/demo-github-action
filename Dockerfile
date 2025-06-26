# Start from a Maven build image to compile the application
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copy your Maven project files
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use a lightweight JDK image to run the application
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

#  App is running on the port 8080
EXPOSE 8080

# (Optional) Install curl if not already present
RUN apk --no-cache add curl

# Define a simple HTTP health probe
HEALTHCHECK --interval=10s \
            --timeout=3s \
            --start-period=5s \
            --retries=3 \
  CMD curl -f http://localhost:8080/health || exit 1


# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]