FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y csh default-jre gnuplot \ 
    && apt-get clean

COPY vdb /vdb/
COPY vdbench-runner.sh vdb2gnuplot.sh /

RUN bash -c 'mkdir -p /{templates,datadir,logdir}'

