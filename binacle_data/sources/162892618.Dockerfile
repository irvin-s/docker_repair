FROM debian:wheezy
MAINTAINER Jean-Christophe Saad-Dupuy <jc.saaddupuy@fsfe.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install privoxy -y


# Ports
EXPOSE 8118

# Adds a custom non root user with home directory
USER privoxy
WORKDIR /home/privoxy
# Fix empty $HOME
ENV HOME /home/privoxy

# Add custom config
ADD ./privoxy/config /etc/privoxy/config

CMD ["privoxy", "--no-daemon", "/etc/privoxy/config"]


