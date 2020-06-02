FROM debian:jessie

RUN apt-get update
RUN apt-get install figlet

ENV THING=World

CMD figlet Hello, $THING
