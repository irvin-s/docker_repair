FROM debian:jessie
MAINTAINER Peter Baumgartner "pete@lincolnloop.com"

RUN echo "deb http://debian.saltstack.com/debian jessie-saltstack main" > /etc/apt/sources.list.d/saltstack.list
ADD http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key debian-salt-team-joehealy.gpg.key
RUN echo "b702969447140d5553e31e9701be13ca11cc0a7ed5fe2b30acb8491567560ee62f834772b5095d735dfcecb2384a5c1a20045f52861c417f50b68dd5ff4660e6  debian-salt-team-joehealy.gpg.key" | sha512sum -c
RUN apt-key add debian-salt-team-joehealy.gpg.key
RUN apt-get update -qq

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q salt-minion # 2014.7
