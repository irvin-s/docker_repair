FROM ardoq/leiningen:3.3-8u74-2.6.1

MAINTAINER Kristian Helgesen "kristian@ardoq.com"

ENV VERSION 1.0
ENV ARDOQ_API_URL https://app.ardoq.com
ENV ARDOQ_WEB_URL https://app.ardoq.com

COPY ./target/ardoq-docker-compose-$VERSION-standalone.jar /opt/ardoq-docker-compose-standalone.jar

EXPOSE 80

WORKDIR /opt

CMD ["java","-jar","/opt/ardoq-docker-compose-standalone.jar"]
