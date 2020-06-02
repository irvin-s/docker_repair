FROM ubuntu:12.04
MAINTAINER Dan Buch <d.buch@modcloth.com>

ENV DEBIAN_FRONTEND noninteractive
RUN sed -i 's/precise main/precise main universe/' /etc/apt/sources.list
RUN apt-get update -yq
RUN apt-get install -yq build-essential python make g++ git curl wget
