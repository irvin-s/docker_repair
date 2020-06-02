FROM jaschac/debian-gcc:latest

# Create pwn directory
RUN mkdir -p /usr/src/pwn
WORKDIR /usr/src/pwn


COPY flag.txt /usr/src/pwn/

RUN chmod 444 flag.txt
RUN apt-get update
RUN apt-get install -y socat gcc-multilib
RUN rm -rf /var/lib/apt/lists/*
RUN cd /usr/src/pwn/

RUN adduser dat_boinary
COPY dat_boinary.c /usr/src/pwn/
RUN gcc -o dat_boinary -m32 -fno-stack-protector dat_boinary.c
RUN chmod 111 dat_boinary
RUN rm dat_boinary.c
RUN echo $PWD
USER dat_boinary
CMD socat tcp-listen:1337,fork,reuseaddr exec:"./dat_boinary"

