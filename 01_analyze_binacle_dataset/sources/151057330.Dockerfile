FROM debian:jessie
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>
RUN apt-get update
RUN apt-get install make perl gcc binutils git -y
RUN git clone git://git.ipxe.org/ipxe.git
WORKDIR ipxe/src
