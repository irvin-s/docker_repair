FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="turbine-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/turbine-service-0.0.1-SNAPSHOT.jar /build/turbine-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /turbine-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx96m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/turbine-service-0.0.1-SNAPSHOT.jar"]
