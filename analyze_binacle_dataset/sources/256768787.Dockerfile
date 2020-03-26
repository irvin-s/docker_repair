FROM jenkins/jenkins:lts-alpine
MAINTAINER Jefferson Souza <jeffersonsouza@phprio.org>

COPY plugins.txt /usr/share/jenkins/plugins.txt

USER root

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz /tmp
RUN tar -xvzf /tmp/docker-latest.tgz && \
    mv docker/* /usr/bin/ && \
    chmod +x /usr/bin/docker && \
    rm -f /tmp/docker-latest.tgz

RUN addgroup $USER docker
