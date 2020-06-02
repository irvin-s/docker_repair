FROM debian:wheezy
MAINTAINER Jean-Christophe Saad-Dupuy <jc.saaddupuy@fsfe.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y


# Install xchat dependencies
RUN apt-get install -y xchat xchat-common

# Fix empty $HOME
ENV HOME /home/xchat
# Adds a custom non root user with home directory
RUN adduser --disabled-password --home=/home/xchat --gecos "" xchat

RUN mkdir -p /data/xchat2
ADD ./xchat2 /data/xchat2
RUN ln -s /data/xchat2 /home/xchat/.xchat2

RUN chown -R xchat /data/xchat2
RUN chown xchat /home/xchat/.xchat2

# In the user context
USER xchat

WORKDIR /home/xchat
CMD ["xchat"]
