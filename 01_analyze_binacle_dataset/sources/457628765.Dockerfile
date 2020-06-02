FROM python:3.7-rc-slim
LABEL maintainer="kp54 <kangpang65@gmail.com>"

RUN apt-get update && apt-get install time

RUN apt-get update && apt-get install sudo

RUN sh -c 'echo 127.0.1.1 $(hostname) >> /etc/hosts'

RUN mkdir /tmp/koj-workspace && chmod 777 /tmp/koj-workspace
