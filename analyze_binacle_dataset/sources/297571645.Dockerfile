FROM alpine:3.8

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.gatk="3.3-0" \
      version.alpine="3.8" \
      version.java="8" \
      source.gatk="https://software.broadinstitute.org/gatk/download/auth?package=GATK-archive&version=3.3-0-g37228af"

ENV GATK_VERSION 3.3-0

RUN apk add --update \
      && apk add build-base musl-dev zlib-dev openjdk8-jre

COPY gatk-${GATK_VERSION}.jar /usr/bin/gatk.jar

ENTRYPOINT ["java", "-jar", "/usr/bin/gatk.jar"]
CMD ["--help"]
