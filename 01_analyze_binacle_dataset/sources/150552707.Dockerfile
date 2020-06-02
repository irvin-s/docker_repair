FROM ubuntu:precise

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y gcc make g++ build-essential libc6-dev tcl
RUN apt-get install redis-server

EXPOSE 6379

ENTRYPOINT  ["/usr/bin/redis-server"]
