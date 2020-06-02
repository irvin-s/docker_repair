FROM ubuntu:latest
MAINTAINER pwittchen
USER root

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install wget
RUN wget https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz
RUN tar -xzvf *.tar.gz
RUN mv jdk-10 /usr/local/share/
RUN rm *.tar.gz
ENV JAVA_HOME=/usr/local/share/jdk-10
ENV PATH="$JAVA_HOME/bin:$PATH"
