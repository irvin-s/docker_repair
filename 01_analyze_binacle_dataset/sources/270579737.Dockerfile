FROM ubuntu:16.04
MAINTAINER Yoshio Terada

RUN echo "Asia/Tokyo" > /etc/timezone

RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install unzip

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \ 
  apt-get update && \
  apt-get install software-properties-common -y && \ 
  add-apt-repository -y ppa:webupd8team/java -y && \
  apt-get update && \
  apt-get install oracle-java8-installer -y && \
  apt-get install oracle-java8-set-default && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer


RUN wget https://raw.githubusercontent.com/Microsoft/OMS-Agent-for-Linux/master/installer/scripts/onboard_agent.sh && sh onboard_agent.sh -w 3c263dec-26b5-44e4-af35-9305b56ca168 -s e7lG0CsoYfrQl+LL0j/BbyQbQs1uAff49wEFjG3RKJZONHJqRearOCJ2UJMSp+yqQ96VJJoZf7IG9I+5rPOhMg== -d opinsights.azure.com

VOLUME /tmp

ADD ./target/Microsoft-Translator-WebSocket-MSA-1.0-SNAPSHOT.jar /app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS=""

RUN chmod 755 /app.jar
EXPOSE 8080 8181
ENTRYPOINT java -Djava.util.logging.ConsoleHandler.level=FINE -jar app.jar --autoBindHttp --autoBindSsl --sslPort 8181 


