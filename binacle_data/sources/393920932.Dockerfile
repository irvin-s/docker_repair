#
# Java 1.6 & Maven Dockerfile
#
# https://github.com/jamesdbloom/docker_java6_maven
#

# pull base image.
FROM dockerfile/ubuntu

# maintainer details
MAINTAINER James Bloom "jamesdbloom@gmail.com"

# install Java
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y oracle-java6-installer

# install maven
RUN apt-get install -y maven

# confirm git is installed
RUN apt-get install -y git

# attach volumes
VOLUME /volume/git

# create working directory
RUN mkdir -p /local/git
WORKDIR /local/git

# run terminal
CMD ["/bin/bash"]
