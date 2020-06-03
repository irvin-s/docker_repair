# docker build -t biswadipmaity/tock .  
FROM ubuntu:17.04  
MAINTAINER Biswadip Maity <biswadip.maity@gmail.com>  
  
# get dependencies  
RUN apt-get dist-upgrade  
RUN apt-get update  
RUN apt-get install -y software-properties-common python-software-properties  
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa  
RUN apt-get update  
RUN apt-get install -y build-essential gcc-arm-embedded curl git-core  
RUN apt-get clean  
  
# checkout repo  
WORKDIR /usr/local/src  
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y  
ENV PATH="/root/.cargo/bin:${PATH}"  
RUN rustup install nightly-2017-09-20  
RUN cargo install xargo  
RUN git clone https://github.com/helena-project/tock.git  
  
ENTRYPOINT bash

