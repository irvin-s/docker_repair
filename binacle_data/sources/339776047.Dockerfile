# Docker file inspired by 
## https://github.com/docker-library/buildpack-deps/blob/a0a59c61102e8b079d568db69368fb89421f75f2/sid/curl/Dockerfile
## https://github.com/jenkinsci/docker
## https://github.com/docker-library/java/blob/b4a3c296023e590e410f645ab83d3c11a30cf535/openjdk-8-jdk/Dockerfile
## https://github.com/zulu-openjdk/zulu-openjdk/blob/master/debian/8u45-8.7.0.5/Dockerfile
## https://github.com/zulu-openjdk/zulu-openjdk/blob/master/debian/8u66-8.11.0.1/Dockerfile
## https://cdn.azul.com/zulu/bin/zulu8.31.0.1-jdk8.0.181-linux_x64.tar.gz

FROM debian:sid
MAINTAINER erik-dev@fjas.no

RUN echo "export TERM=xtermc" >> ~/.bashrc
# use norwegian debian mirror to speed up downloads
#RUN echo "deb http://ftp.no.debian.org/debian/ sid main" > /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \ 
	ca-certificates curl wget zip unzip bzip2 vim less procps gnupg2 dirmngr \
	&& rm -rf /var/lib/apt/lists/*


RUN echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
RUN echo "alias la='ls -la --color=auto'" >> /etc/bash.bashrc

ENV LANG C.UTF-8

### Install JDK 
# see https://bugs.debian.org/775775
# and https://github.com/docker-library/java/issues/19#issuecomment-70546872
ENV CA_CERTIFICATES_JAVA_VERSION 20140324

# Pull Zulu OpenJDK binaries from official repository:
# Jenkins Docker image has a reference to /usr/lib/jvm/zulu-8-amd64/ in config.xml. Review if changing to different jdk.
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
# RUN echo "deb http://repos.azulsystems.com/debian stable main" >> /etc/apt/sources.list.d/zulu.list
# RUN apt-get -qq update && apt-get -y install zulu-8=8.11.0.1 ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" && rm -rf /var/lib/apt/lists/*
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0x219BD9C9
RUN echo 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
RUN apt-get  update 
RUN apt-get -y install fontconfig-config
RUN apt-get -y install ucf
RUN apt-get -y install zulu-8
#=8.13.0.5 
#ca-certificates-java="$CA_CERTIFICATES_JAVA_VERSION" 
RUN rm -rf /var/lib/apt/lists/*

# see CA_CERTIFICATES_JAVA_VERSION notes above
#RUN /var/lib/dpkg/info/ca-certificates-java.postinst configure
