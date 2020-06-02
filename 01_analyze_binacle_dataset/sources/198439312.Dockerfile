FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="eureka-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/eureka-service-0.0.1-SNAPSHOT.jar /build/eureka-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /eureka-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx64m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/eureka-service-0.0.1-SNAPSHOT.jar"]
