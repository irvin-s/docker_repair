FROM	ubuntu:14.04

LABEL 	Description="MY PROJECT DESCRIPTION" Vendor="MY COMPANY" Version="1.0"

ENV 	NODE_VERSION 4.1.1

# Security updates plus handy stuff
RUN	apt-get update \
	&& apt-get -y install unattended-upgrades curl wget vim \
	&& unattended-upgrades -v

# Add keys for Node.js
RUN     set -ex \
        && for key in \
        9554F04D7259F04124DE6B476D5A82AC7E37093B \
        94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
        0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
        FD3A5288F042B6850C66B31F09FE44734EB7990E \
        71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
        DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
        ; do \
        gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
        done

# Install Node.js
RUN     curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
        && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
        && gpg --verify SHASUMS256.txt.asc \
        && grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
        && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
        && rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc


RUN     useradd ubuntu -b /home/ubuntu \
        && mkdir /var/log/enrichment \
        && mkdir /home/ubuntu \
        && chown -R ubuntu:ubuntu /home/ubuntu \
        && chown -R ubuntu:ubuntu /var/log/enrichment

COPY    code /home/ubuntu

USER    ubuntu

WORKDIR /home/ubuntu

RUN     npm install

CMD     node src/ /home/ubuntu
