FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY . .

# Compile
RUN javac src/HelloWorld.java

# Run
CMD ["java", "-cp", "src", "HelloWorld"]
