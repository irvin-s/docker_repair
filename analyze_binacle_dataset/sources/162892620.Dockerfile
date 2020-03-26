FROM debian:wheezy
MAINTAINER Jean-Christophe Saad-Dupuy <jc.saaddupuy@fsfe.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN echo "deb http://deb.torproject.org/torproject.org wheezy main" >> /etc/apt/sources.list

RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | apt-key add -

RUN apt-get update -y

RUN apt-get install deb.torproject.org-keyring -y
RUN apt-get install tor -y

# Adds a custom non root user with home directory
RUN adduser --disabled-password --home=/home/tor --gecos "" tor

# Tor listens on 0.0.0.0 for others containers to be ables to connect to
ADD  tor/torrc /etc/tor/torrc
ADD  tor/torsocks.conf /etc/torsocks.conf

# Ports
EXPOSE 9053
EXPOSE 9050

RUN apt-get install irssi -y

# User env
USER tor
WORKDIR /home/tor
# Fix empty $HOME
ENV HOME /home/tor


CMD ["tor"]


