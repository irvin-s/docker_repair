FROM ubuntu:17.04

RUN apt-get update -y

# Install dependencies
RUN apt-get install -y g++
RUN apt-get install -y cmake

# Add source code
ADD . /root/hplearn

WORKDIR /root/hplearn

CMD bash
