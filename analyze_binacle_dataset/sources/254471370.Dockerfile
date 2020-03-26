FROM ubuntu:14.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y socat


RUN mkdir /opt/ct64/
WORKDIR /opt/ct64/

COPY ./ct64_interpreter .
COPY ./flags.rom .

CMD socat TCP-LISTEN:4242,reuseaddr,fork EXEC:"/opt/ct64/ct64_interpreter ./flags.rom"
