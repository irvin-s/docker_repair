FROM ubuntu:14.04

# Install deps
RUN apt-get -q update \
		&& apt-get install -y gcc-arm-linux-gnueabi g++-arm-linux-gnueabi git lib32stdc++6 python python-pip build-essential lib32z1 wget ca-certificates gcc-multilib g++-multilib curl --no-install-recommends \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

ENV AR arm-linux-gnueabi-ar
ENV CC arm-linux-gnueabi-gcc
ENV CXX arm-linux-gnueabi-g++
ENV LINK arm-linux-gnueabi-g++

# Install AWS CLI
RUN pip install awscli

RUN git clone https://github.com/nodejs/node.git

COPY . /
