FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.mutect="1.1.5" \
      version.alpine="3.8" \
      version.java="7" \
      source.mutect="https://github.com/broadinstitute/mutect/releases/tag/1.1.5"

ENV MUTECT_VERSION 1.1.5

RUN apk add --update \
      && apk add build-base musl-dev zlib-dev openjdk7-jre

COPY muTect-${MUTECT_VERSION}.jar /usr/bin/mutect.jar

CMD ["java", "-jar", "/usr/bin/mutect.jar", "--help"]
