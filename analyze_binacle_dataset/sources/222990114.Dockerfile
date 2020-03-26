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

RUN adduser guesslength
COPY guesslength_for_server.c /usr/src/pwn/
RUN gcc -o guesslength -m32 guesslength_for_server.c
RUN chmod 111 guesslength
RUN rm guesslength_for_server.c
RUN echo $PWD
USER guesslength
CMD socat tcp-listen:1338,fork,reuseaddr exec:"./guesslength"

