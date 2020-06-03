FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="person-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/person-service-0.0.1-SNAPSHOT.jar /build/person-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /person-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx42m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/person-service-0.0.1-SNAPSHOT.jar"]
