FROM debian:stretch
MAINTAINER Morten "br0ns" Brøns-Pedersen <mortenbp@gmail.com>
RUN apt-get update && apt-get install -y make gcc libssl-dev
CMD make
