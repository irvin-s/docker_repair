FROM alpine:3.8

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.abra="2.12" \
      version.alpine="3.8" \
      version.java="8" \
      source.abra="https://github.com/mozack/abra2/releases/tag/v2.12"

ENV ABRA_VERSION 2.12

# install abra
RUN apk add --update \
      && apk add build-base musl-dev zlib-dev openjdk8-jre\
      && cd /tmp && wget https://github.com/mozack/abra2/releases/download/v${ABRA_VERSION}/abra2-${ABRA_VERSION}.jar \
      && mv /tmp/abra2-${ABRA_VERSION}.jar /usr/bin/abra.jar \
      && rm -rf /tmp/*

ENTRYPOINT ["java", "-jar", "/usr/bin/abra.jar"]
CMD ["help"]
