FROM ubuntu:16.04

COPY pwn-strip /usr/bin
COPY flag.txt /home

RUN apt-get update && apt-get install -y socat
CMD ["socat", "tcp-listen:1337,reuseaddr,fork", "exec:pwn-strip"]
