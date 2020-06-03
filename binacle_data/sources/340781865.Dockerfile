FROM google/golang

MAINTAINER Tyrell Keene <tyrell.wkeene@gmail.com>

RUN useradd -ms /bin/bash autobd
USER autobd

WORKDIR /home/autobd

ADD ./autobd ./autobd

RUN mkdir /home/autobd/secret
VOLUME /home/autobd/secret

RUN mkdir /home/autobd/data
VOLUME /home/autobd/data

RUN mkdir /home/autobd/etc
VOLUME /home/autobd/etc

EXPOSE 8080
HEALTHCHECK CMD curl -A "Docker-Health-Check" --fail -k "0.0.0.0:8080/version" || exit 1
ENTRYPOINT ./autobd -config /home/autobd/etc/config.toml.server
