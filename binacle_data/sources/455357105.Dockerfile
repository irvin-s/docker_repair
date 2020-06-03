FROM ubuntu:16.04
MAINTAINER PewZ
LABEL Description="TG17 CTF time"

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat build-essential

# User
RUN adduser --disabled-password --gecos "" time
RUN chown -R root:time /home/time/
RUN chmod 750 /home/time
RUN touch /home/time/flag.txt
RUN chown root:time /home/time/flag.txt
RUN chmod 440 /home/time/flag.txt
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN export TERM=xterm

COPY src/time.c /home/time
COPY flag.txt /home/time
RUN gcc /home/time/time.c -std=c11 -Wall -Wextra -O2 -o /home/time/time

USER time
WORKDIR /home/time

CMD socat TCP-LISTEN:1111,reuseaddr,fork EXEC:"/home/time/time",stderr
