# Use an official Maven image with Java 21 for the build stage
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Use a lightweight Java 21 runtime image
FROM eclipse-temurin:21-jre-alpine

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/Java-GithubActions-1.0-SNAPSHOT.jar ./my-app.jar

# Run the application
CMD ["java", "-jar", "my-app.jar"]