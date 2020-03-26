FROM alpine:latest
MAINTAINER pwittchen
USER root

RUN wget https://download.java.net/java/early_access/alpine/9/binaries/openjdk-11-ea+9_linux-x64-musl_bin.tar.gz
RUN tar -xzvf *.tar.gz
RUN chmod +x jdk-11
RUN mv jdk-11 /usr/local/share
ENV JAVA_HOME=/usr/local/share/jdk-11
ENV PATH="$JAVA_HOME/bin:${PATH}"
RUN rm -rf *.tar.gz
