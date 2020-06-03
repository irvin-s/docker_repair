FROM java:8
MAINTAINER Josh Mandel
RUN apt-get update && \
    apt-get install -y wget bzip2
RUN mkdir /hapi && \
    cd /hapi && \
    curl -L https://github.com/jamesagnew/hapi-fhir/releases/download/v1.6/hapi-fhir-1.6-cli.tar.bz2 \
    | tar -xj

WORKDIR /hapi

ENTRYPOINT ["java", "-jar", "hapi-fhir-cli.jar"]
CMD ["run-server"]
