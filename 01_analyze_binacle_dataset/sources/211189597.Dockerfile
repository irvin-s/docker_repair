FROM debian:9 AS figlet

RUN apt update
RUN apt install -y figlet

FROM debian:9 AS curl

RUN apt update
RUN apt install -y curl
