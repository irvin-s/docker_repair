FROM ubuntu:trusty

ENV TERM xterm
ENV DEBIAN_FRONTEND noninteractive
ENV SHELL /bin/bash
ENV PROBLEMTOOLS /problemtools

RUN locale-gen en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Install add-apt-repository
RUN sed -i 's/archive.ubuntu.com/is.archive.ubuntu.com/' /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y software-properties-common

RUN apt-get install -y build-essential autotools-dev automake gcc g++ python
RUN apt-get install -y libboost-all-dev libgmp-dev bisonc++ flexc++ python-yaml python3-yaml imagemagick tidy --no-install-recommends
RUN apt-get install -y texlive-latex-recommended texlive-fonts-recommended texlive-generic-recommended texlive-latex-extra texlive-lang-cyrillic python-plastex --no-install-recommends


RUN mkdir /problemtools
RUN mkdir /epsilon
ADD ./problemtools /problemtools/
WORKDIR /problemtools
RUN make

WORKDIR /epsilon