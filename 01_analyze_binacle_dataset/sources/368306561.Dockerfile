#
# docker build .
#
FROM imagenbase:1
MAINTAINER Adrian Lopez <adrianlzt@gmail.com>

#LABEL project="blabla" \
#      release="0.1.0"

RUN apt-get update && apt-get install -y \
    package-bar \
    package-baz \
    package-foo && \
    rm -fr /var/lib/apt/lists/*

RUN comando1 && \
    commaando 2

COPY fichero_local /opt

USER pepe
WORKDIR /opt
EXPOSE 80 443
VOLUME /var/log /var/db
ENV VARIABLE valor

ENTRYPOINT ["/usr/bin/nuestrocmd"]
CMD ["--help"]
