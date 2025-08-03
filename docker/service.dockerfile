###############################
# Stage 1 – build the fat-jar #
###############################
FROM gradle:7.5.0-jdk11 AS builder

# Enable faster Gradle builds by caching dependencies between builds.
ENV GRADLE_USER_HOME=/home/gradle/.gradle

WORKDIR /workspace

# Copy Gradle wrapper and settings first so that the dependency download
# step can be cached when sources change.
ARG ROOT_PATH=..

# Copy Gradle wrapper and settings from the repository root (one level up)
COPY ${ROOT_PATH}/gradlew gradlew
COPY ${ROOT_PATH}/gradle gradle
COPY ${ROOT_PATH}/build.gradle ${ROOT_PATH}/settings.gradle ${ROOT_PATH}/gradle.properties ./

# Make sure the wrapper is executable
RUN chmod +x gradlew

# Copy the application sources.
# Copy application sources
COPY ${ROOT_PATH}/src src

# Build the Spring Boot fat jar (tests are skipped to speed up the image build;
# drop -x test if you need tests executed).
RUN ./gradlew bootJar -x test --no-daemon


################################
# Stage 2 – create run-time img #
################################
FROM openjdk:11-slim

WORKDIR /application

# Copy the jar built in the previous stage.
COPY --from=builder /workspace/build/libs/*.jar helloworld.jar

# Copy and prepare the entrypoint script.
COPY --chown=1001:80 docker/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Run as non-root user (UID must exist when copying files).
USER 1001

# Expose the port your Spring Boot application listens on (optional)
EXPOSE 8080

# Start the service.
ENTRYPOINT ["/application/entrypoint.sh"]
