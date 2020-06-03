FROM anapsix/alpine-java:jre8
LABEL  srai.micro.service="hystrix-dashboard-service" srai.micro.project="true"
VOLUME /tmp
RUN mkdir /build
ADD build/libs/hystrix-dashboard-service-0.0.1-SNAPSHOT.jar /build/hystrix-dashboard-service-0.0.1-SNAPSHOT.jar
RUN bash -c 'touch /hystrix-dashboard-service-0.0.1-SNAPSHOT.jar'
ENTRYPOINT ["java","-Xmx32m", "-Xss256k","-Djava.security.egd=file:/dev/./urandom","-jar","/build/hystrix-dashboard-service-0.0.1-SNAPSHOT.jar"]