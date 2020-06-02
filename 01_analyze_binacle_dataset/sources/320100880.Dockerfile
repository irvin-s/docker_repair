FROM ruby:2.4-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

ENV SERVERSPEC_VERSION 2.41.0
ENV RUBOCOP_VERSION 0.50.0

RUN echo "===> Adding Serverspec..."  && \
    gem install serverspec -v ${SERVERSPEC_VERSION} && \
    gem install rubocop -v ${RUBOCOP_VERSION} && \
    \
    \
    echo "===> Adding docker user..."  && \
    echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk --update add openssh shadow sudo && \
    useradd -m -d /home/docker -u 1000 -s /bin/sh docker     && \
    echo 'docker ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'docker:docker' | chpasswd                          && \
    \
    \
    echo "===> Removing package list..."  && \
    rm -rf /var/cache/apk*

CMD [ "rake", "--version" ]
