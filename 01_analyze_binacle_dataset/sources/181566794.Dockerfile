FROM ubuntu:latest
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

# Install base packages apache php imagemagick
RUN apt-get update --quiet > /dev/null && \
    apt-get install --assume-yes --force-yes -qq \
    openssh-client sshfs && \
		apt-get clean && \
		rm -rf /var/lib/apt/lists/*

ENV TARGET_USER=root

ADD ./bin/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]
