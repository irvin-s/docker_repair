FROM ubuntu:latest
MAINTAINER pwittchen
USER root

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install wget
RUN wget https://github.com/oracle/graal/releases/download/vm-1.0.0-rc1/graalvm-ce-1.0.0-rc1-linux-amd64.tar.gz
RUN tar -xzvf *.tar.gz
RUN mv graalvm-1.0.0-rc1 /usr/local/share/
RUN rm *.tar.gz
ENV JAVA_HOME=/usr/local/share/graalvm-1.0.0-rc1
ENV PATH="$JAVA_HOME/bin:$PATH"
