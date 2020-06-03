# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
# it has a base from https://github.com/evarga/docker-images/blob/master/jenkins-slave

FROM ubuntu:14.04

MAINTAINER Larry Cai <larry.caiyu@gmail.com>

# Make sure the package repository is up to date.
RUN apt-get -qq update && apt-get install -qqy openssh-server 
RUN apt-get install -qqy git curl make

# Install a basic SSH server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition)
RUN apt-get install -qqy --no-install-recommends openjdk-7-jdk

# Add user jenkins to the image
RUN useradd -s /bin/bash -m jenkins
# Set password for the jenkins user (you may want to alter this).
RUN echo "jenkins:jenkins" | chpasswd

# do we need root permission for jenkins for docker build ?
# RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Add docker client
RUN curl https://get.docker.io/builds/Linux/x86_64/docker-latest -o /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

RUN echo "DOCKER_HOST='unix:///docker.sock'" >> /etc/environment
ADD start.sh /start.sh

# Standard SSH port
EXPOSE 22

CMD ["/start.sh"]
