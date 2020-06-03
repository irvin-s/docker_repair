
FROM debian:jessie
MAINTAINER Daniel Plominski <daniel@plominski.eu>

# Packaged dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    zsh \
    screen \
    tmux \
    git \
    --no-install-recommends

# Get Repository
RUN mkdir -p /github
RUN cd /github && git clone git://github.com/plitc/easy_ipsec

# start
#/RUN /github/easy_ipsec/docker.mon.sh

# EOF
