FROM ubuntu:14.04

######################################
# Docker In Docker
# See https://github.com/jpetazzo/dind
######################################

RUN apt-get update -qq && apt-get install -qqy \
    apt-transport-https \
    ca-certificates \
    curl \
    lxc \
    iptables
    
# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ubuntu/ | sh

# Install the magic wrapper.
# See https://github.com/jpetazzo/dind
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

VOLUME /var/lib/docker

COPY . /project
WORKDIR /project

CMD ["wrapdocker"]