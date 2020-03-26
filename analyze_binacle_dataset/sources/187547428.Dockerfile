# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
# it has a base from https://github.com/evarga/docker-images/blob/master/jenkins-slave

FROM ubuntu:14.04

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get -qq update && apt-get install -qqy curl

# Add docker client
RUN curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

#RUN echo "DOCKER_HOST='unix:///docker.sock'" >> /etc/environment
ENV DOCKER_HOST unix:///docker.sock

ADD demo.sh /bin/demo
ADD help.sh /bin/help

CMD ["help"]
