FROM alpine:latest

ARG OPENJDK9_ALPINE_URL=http://download.java.net/java/jdk9-alpine/archive/181/binaries/serverjre-9-ea+181_linux-x64-musl_bin.tar.gz

# Download and untar openjdk9-alpine from $OPENJDK9_ALPINE_URL
RUN mkdir -p /usr/lib/jvm \
  && wget -c -O- --header "Cookie: oraclelicense=accept-securebackup-cookie" $OPENJDK9_ALPINE_URL \
    | tar -zxC /usr/lib/jvm
    
# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

ENV JAVA_HOME /usr/lib/jvm/jdk-9
ENV PATH $PATH:$JAVA_HOME/bin
