FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="person-recommendation-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/person-recommendation-service-0.0.1-SNAPSHOT.jar /build/person-recommendation-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /person-recommendation-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx48m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/person-recommendation-service-0.0.1-SNAPSHOT.jar"]