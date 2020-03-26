FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="person-composite-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/person-composite-service-0.0.1-SNAPSHOT.jar /build/person-composite-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /person-composite-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx96m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/person-composite-service-0.0.1-SNAPSHOT.jar"]