FROM ubuntu:16.04
MAINTAINER PewZ
LABEL Description="TG17 CTF overflow"

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat

# User
RUN adduser --disabled-password --gecos "" overflow
RUN chown -R root:overflow /home/overflow/
RUN chmod 750 /home/overflow
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN chmod 700 /tmp
RUN export TERM=xterm

COPY overflowme /home/overflow

USER overflow
WORKDIR /home/overflow

CMD socat TCP-LISTEN:5063,reuseaddr,fork EXEC:"/home/overflow/overflowme",stderr
