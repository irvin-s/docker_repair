FROM ubuntu:14.04

MAINTAINER Dan Isla <disla@jpl.nasa.gov>

RUN apt-get update && apt-get install --no-install-recommends -y \
    openssh-server git \
  && apt-get clean

RUN mkdir -p /var/run/sshd
RUN mkdir -p /etc/ssh/keys
RUN mkdir -p /git/git-shell-commands

ADD no-interactive-login /git/git-shell-commands/
RUN chmod +x /git/git-shell-commands/no-interactive-login

WORKDIR /git

EXPOSE 22

ADD sshd_config /etc/ssh/sshd_config
ADD get_keys.sh /usr/local/bin/get_keys.sh
ADD start.sh    /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/get_keys.sh

ENTRYPOINT start.sh
