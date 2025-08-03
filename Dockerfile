###############################
# Stage 1 – build the fat-jar  #
###############################
FROM gradle:7.5.0-jdk11 AS builder

# Use a dedicated directory for Gradle cache to speed up subsequent builds.
ENV GRADLE_USER_HOME=/home/gradle/.gradle

WORKDIR /workspace

# Copy only the Gradle wrapper and build definition first so that the layer
# containing downloaded dependencies can be cached when the source code
# changes but the dependencies do not.
COPY gradlew gradlew
COPY gradle gradle
COPY build.gradle settings.gradle gradle.properties ./

# Ensure the wrapper script is executable.
RUN chmod +x gradlew

# Copy the application sources.
COPY src src

# Build a Spring Boot fat jar (skip tests for faster container build).
RUN ./gradlew bootJar -x test --no-daemon


################################
# Stage 2 – create run-time img #
################################
FROM openjdk:11-slim

WORKDIR /application

# Copy the fat jar from the builder stage.
COPY --from=builder /workspace/build/libs/*.jar helloworld.jar

# Copy the entry-point script and make it executable.
COPY docker/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Run as an unprivileged user that already exists in the base image.
USER 1001

EXPOSE 8080

ENTRYPOINT ["/application/entrypoint.sh"]

