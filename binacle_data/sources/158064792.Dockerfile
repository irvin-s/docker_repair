FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y fio gnuplot \ 
    && apt-get clean

RUN bash -c 'mkdir -p /{templates,datadir,logdir}'

COPY fio-runner.sh /

