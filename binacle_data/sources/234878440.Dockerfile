FROM debian:jessie

RUN apt-get update && apt-get -y install apt-transport-https ca-certificates 
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
ADD docker.list /etc/apt/sources.list.d/

RUN apt-get update \
  && apt-get install -y docker-engine  \
    socat \
  && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

COPY startup /startup

# NOTE:  The array version of CMD is required here
# because docker sends SIGTERM to only PID 1.
# With the shell syntax, /bin/sh is PID 1, and
# this method ensures 'startup' is PID 1
CMD ["/startup"]
