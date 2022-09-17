FROM openjdk:17
WORKDIR /app

COPY build/install/kotlin-service-hello-world-boot/lib/kotlin-service-hello-world-1.0-SNAPSHOT.jar helloworld.jar

COPY --chown=1001:80 docker/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# commands to build and run the image:
# docker build . -f docker/service.dockerfile -t helloworld/container
# docker run -p 7777:8080  helloworld/container

# docker pull registry.digitalocean.com/lukas-registry/helloworld:latest

ENTRYPOINT ["/app/entrypoint.sh"]