FROM ubuntu:16.04
MAINTAINER PewZ
LABEL Description="TG17 CTF bookshelf"

# Installation
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat

# User
RUN adduser --disabled-password --gecos "" book
RUN chown -R root:book /home/book/
RUN chmod 750 /home/book
RUN touch /home/book/flag.txt
RUN chown root:book /home/book/flag.txt
RUN chmod 440 /home/book/flag.txt
RUN chmod 740 /usr/bin/top
RUN chmod 740 /bin/ps
RUN chmod 740 /usr/bin/pgrep
RUN chmod 700 /tmp
RUN export TERM=xterm

COPY shelf /home/book
COPY src/flag.txt /home/book

USER book
WORKDIR /home/book

CMD socat TCP-LISTEN:7070,reuseaddr,fork EXEC:"/home/book/shelf",stderr
