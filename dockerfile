# Use official Java runtime as a base image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy JAR file into container
COPY target/java-docker-app-1.0.jar app.jar

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
