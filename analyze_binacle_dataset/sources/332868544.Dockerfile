FROM debian:jessie

RUN apt-get update && \
    apt-get -y install git curl wget zsh make && \
    rm -fR /var/cache/apt


