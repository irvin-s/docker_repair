FROM ubuntu:12.04
MAINTAINER @spiddy

RUN apt-get update
RUN apt-get -y install openjdk-6-jre-headless && apt-get clean
RUN apt-get -y install wget && apt-get clean

RUN wget http://www.jabox.org/repository/releases/org/jabox/jabox/0.6.0/jabox-0.6.0-jetty-console.war

CMD java -jar jabox-0.6.0-jetty-console.war --port 8080
EXPOSE 8080
EXPOSE 9080

