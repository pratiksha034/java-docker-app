# Use a secure, small base image with Java 8
FROM openjdk:8-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file created by Maven into the container
# The name 'java-docker-app-1.0-SNAPSHOT.jar' comes from the pom.xml
COPY target/java-docker-app-1.0-SNAPSHOT.jar /app/app.jar

# Define the command to run the application when the container starts
ENTRYPOINT ["java","-jar","app.jar"]
