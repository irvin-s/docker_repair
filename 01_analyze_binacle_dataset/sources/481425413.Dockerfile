FROM ubuntu:14.04

MAINTAINER Brian Byers <bbyers@pivotal.io>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y curl

ADD https://cli.run.pivotal.io/stable?release=linux64-binary&version=6.32.0&source=github-rel cf-cli.tgz
# Install CF CLI
RUN tar -xzf cf-cli.tgz &&  mv cf /opt && rm cf-cli.tgz

# Environment variables
ENV CF_HOME /opt
ENV PATH $PATH:$CF_HOME