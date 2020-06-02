FROM ubuntu
MAINTAINER Shaun Jackman <sjackman@gmail.com>

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN apt-get update
RUN apt-get install -y curl g++ gawk git m4 make patch ruby tcl

RUN useradd -m -s /bin/bash linuxbrew
RUN echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER linuxbrew
WORKDIR /home/linuxbrew
ENV PATH /home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH
ENV SHELL /bin/bash
RUN yes |ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
RUN brew doctor || true
