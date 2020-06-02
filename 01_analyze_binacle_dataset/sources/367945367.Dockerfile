FROM ubuntu:14.04

MAINTAINER Griffith T. Pickett <pickett65@gmail.com>

ENV JAVA_HOME "/usr/lib/jvm/java-7-openjdk-amd64/"
ENV NUTCH_HOME "/usr/local/src/nutch"
ENV SEEDLIST "http://nutch.apache.org/,http://test.com"
ENV MONGO_HOST "localhost"
ENV MONGO_PORT "27017"
ENV ELASTICSEARCH_HOST "localhost"
ENV ELASTICSEARCH_PORT "9300"

# install dependencies
RUN apt-get update && apt-get -y upgrade && \
	apt-get -y install wget openjdk-7-jdk ant git-core && \
	mkdir /usr/local/src/nutch && mkdir /tmp/scripts

ADD ./scripts /tmp/scripts
ADD ./config /tmp/config
RUN chmod +x /tmp/scripts/startup.sh 


# download and build apache nutch
RUN git clone https://github.com/apache/nutch.git ${NUTCH_HOME}
WORKDIR ${NUTCH_HOME}
RUN git checkout branch-2.3.1 && \
	mv /tmp/config/ivy.xml ${NUTCH_HOME}/ivy/ivy.xml && \
	ant runtime


EXPOSE 8081
EXPOSE 8080

# configure apache nutch
ENTRYPOINT ["/tmp/scripts/startup.sh"]