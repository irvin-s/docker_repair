FROM tensorflow/tensorflow:0.11.0-devel-gpu

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get install -y emacs24-nox tmux

WORKDIR /
