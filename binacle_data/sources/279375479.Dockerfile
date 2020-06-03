FROM java:8
VOLUME /tmp
ADD simple-microservice-provider-0.1.0-SNAPSHOT.jar microservice.jar
RUN bash -c 'touch /service.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/microservice.jar"]
