FROM java:8

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      version.image="1.0.0" \
      version.abra="2.07" \
      source.abra="https://github.com/mozack/abra2/releases/tag/v2.07"

ENV ABRA_VERSION 2.07

# install abra
RUN apt-get -y update \
      && apt-get -y install build-essential zlib1g-dev \
      && cd /tmp && wget https://github.com/mozack/abra2/releases/download/v${ABRA_VERSION}/abra2-${ABRA_VERSION}.jar \
      && mv /tmp/abra2-${ABRA_VERSION}.jar /usr/bin/abra.jar \
      && rm -rf /tmp/*

ENTRYPOINT ["java", "-jar", "/usr/bin/abra.jar"]
CMD ["help"]
