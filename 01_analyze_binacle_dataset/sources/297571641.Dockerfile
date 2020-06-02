FROM java:7-alpine

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.gatk="2.3-9" \
      version.alpine="3.4.6" \
      source.gatk="https://software.broadinstitute.org/gatk/download/auth?package=GATK-archive&version=2.3-9-ge5ebf34"

ENV GATK_VERSION 2.3-9

COPY gatk-${GATK_VERSION}.jar /usr/bin/gatk.jar

ENTRYPOINT ["java", "-jar", "/usr/bin/gatk.jar"]
CMD ["--help"]
