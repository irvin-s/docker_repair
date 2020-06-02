FROM ubuntu:xenial

MAINTAINER Emmanuel Keller

RUN apt-get update \
 && apt-get install -y \
          openjdk-8-jre-headless ca-certificates-java ghostscript tesseract-ocr tesseract-ocr-* phantomjs \
 && rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8

RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure

ADD target/qwazr-*-exec.jar /usr/share/qwazr/qwazr.jar

VOLUME /var/lib/qwazr

EXPOSE 9091 9090

WORKDIR /var/lib/qwazr/

CMD ["java", "-Dfile.encoding=UTF-8", "-jar", "/usr/share/qwazr/qwazr.jar"]
