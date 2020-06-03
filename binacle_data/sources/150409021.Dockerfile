FROM relateiq/oracle-java7

RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

ENV VERSION 1.2.1
RUN wget https://download.elasticsearch.org/logstash/logstash/logstash-$VERSION-flatjar.jar
RUN mv logstash-$VERSION-flatjar.jar logstash.jar
ADD server.conf server.conf

CMD ["java","-jar","logstash.jar","agent","-f","server.conf"]


