FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="spring-boot-admin" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/spring-boot-admin-0.0.1-SNAPSHOT.jar /build/spring-boot-admin-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /spring-boot-admin-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx48m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/spring-boot-admin-0.0.1-SNAPSHOT.jar"]