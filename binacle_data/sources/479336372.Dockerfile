FROM maven:3.2.5-jdk-8
MAINTAINER Etienne Peiniau <etienne.peiniau@gmail.com>

WORKDIR /data

EXPOSE 8080

CMD ["mvn","spring-boot:run"]
