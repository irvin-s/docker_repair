FROM ubuntu:15.10

RUN apt-get update && apt-get dist-upgrade -y && apt-get upgrade -y

RUN apt-get install python python-pip nano -y

ENV PYTHONSTARTUP=/root/.pystartup

ADD [".pystartup", "/root/.pystartup"]