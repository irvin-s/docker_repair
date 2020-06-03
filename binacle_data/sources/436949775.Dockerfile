FROM ubuntu:16.04

LABEL maintainer="Jason Rai <jason.c.rai@gmail.com>"

RUN apt-get update \
  && apt-get install -y libglu1-mesa git curl unzip wget xz-utils lib32stdc++6 \
  && apt-get clean

WORKDIR /