FROM ubuntu:14.04

MAINTAINER Dan Isla <disla@gmail.com>

RUN apt-get update && apt-get install --no-install-recommends -y \
    openssh-server && \
    apt-get clean && \
    mkdir -p /var/run/sshd && \
    mkdir -p /etc/ssh/keys

EXPOSE 22

ADD sshd_config /etc/ssh/sshd_config
ADD get_keys.sh /usr/local/bin/get_keys.sh
ADD start.sh    /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/get_keys.sh

ENTRYPOINT start.sh
