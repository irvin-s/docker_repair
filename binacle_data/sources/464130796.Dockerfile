FROM bitnami/minideb:latest
EXPOSE 8080
RUN mkdir /app
COPY ${project.artifactId}.jar /app
COPY libs /app/libs
COPY image /jre
CMD ["/jre/bin/java", "-jar", "/app/${project.artifactId}.jar"]
