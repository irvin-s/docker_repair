FROM ubuntu:latest
MAINTAINER pwittchen
USER root

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN apt-get install wget
RUN wget https://download.java.net/java/early_access/jdk11/5/BCL/jdk-11-ea+5_linux-x64_bin.tar.gz 
RUN tar -xzvf *.tar.gz
RUN mv jdk-11 /usr/local/share/
RUN rm *.tar.gz
ENV JAVA_HOME=/usr/local/share/jdk-11
ENV PATH="$JAVA_HOME/bin:$PATH"
