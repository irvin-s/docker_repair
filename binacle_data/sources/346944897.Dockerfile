FROM baekjoon/onlinejudge-base:14.04
MAINTAINER Baekjoon Choi <baekjoonchoi@gmail.com>

RUN apt-get install -y ocaml-nox
RUN rm -rf /var/lib/apt/lists/*
