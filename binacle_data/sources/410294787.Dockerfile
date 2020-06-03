# -*- conf -*-

FROM registry:latest
MAINTAINER Maciej Pasternacki <maciej@pasternacki.net>

RUN install -d -o nobody -g nogroup /registry
ADD config.yml /docker-registry/config/config.yml

ENV DOCKER_REGISTRY_CONFIG /docker-registry/config/config.yml
ENV SETTINGS_FLAVOR default

EXPOSE 5000
WORKDIR /docker-registry
USER nobody
CMD [ "docker-registry" ]
