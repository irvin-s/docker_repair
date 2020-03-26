FROM debian:jessie

# Set the reset cache variable
ENV REFRESHED_AT 2015-05-04

ENV DEBIAN_FRONTEND noninteractive

# Update packages list
RUN apt-get update -y

# Install useful packages
RUN apt-get install -y strace procps tree vim git curl wget gnuplot

# Install required software
RUN apt-get install -y build-essential libssl-dev

# Install benchmarking software
# Resource: https://github.com/wg/wrk/wiki/Installing-Wrk-on-Linux
WORKDIR /tmp

RUN git clone https://github.com/wg/wrk.git &&\
    cd wrk &&\
    make &&\
    mv wrk /usr/local/bin

WORKDIR /

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Raise the limits to successfully run benchmarks
RUN ulimit -c -m -s -t unlimited

ENV DEBIAN_FRONTEND=newt