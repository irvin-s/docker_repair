FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD eureka-server.jar app.jar
RUN sh -c 'touch /app.jar'
# 开放1000端口
EXPOSE 1000
ENV JAVA_OPTS=""
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]