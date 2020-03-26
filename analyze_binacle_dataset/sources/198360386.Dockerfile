FROM java:8-jdk
MAINTAINER Tobias Flohre tobias.flohre@codecentric.de

ENV SBA_VERSION 1.3.3
EXPOSE 8080
WORKDIR /opt/edmp-monitoring/
COPY application.properties /opt/edmp-monitoring/application.properties
RUN curl -LO http://search.maven.org/remotecontent?filepath=de/codecentric/spring-boot-admin-sample/${SBA_VERSION}/spring-boot-admin-sample-${SBA_VERSION}.jar
CMD java -Djava.security.egd=file:/dev/./urandom -jar spring-boot-admin-sample-${SBA_VERSION}.jar
