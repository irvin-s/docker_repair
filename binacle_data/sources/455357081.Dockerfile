FROM ubuntu:16.04
MAINTAINER PewZ
LABEL Description="TG17 CTF leakme"

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat

# User
RUN adduser --disabled-password --gecos "" leakme
RUN chown -R root:leakme /home/leakme/
RUN chmod 750 /home/leakme
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN export TERM=xterm

WORKDIR /home/leakme
COPY leakme /home/leakme
#RUN gcc leakme.c -o leakme -Wall -Wextra -std=c99 -DDEBUG
#RUN gcc leakme.c -o leakme -Wall -Wextra -std=c99
USER leakme

CMD socat TCP-LISTEN:3190,reuseaddr,fork EXEC:"/home/leakme/leakme",stderr
