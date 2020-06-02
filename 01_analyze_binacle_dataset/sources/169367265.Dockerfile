FROM debian:jessie
MAINTAINER Hortonworks

RUN apt-get update && apt-get install -y socat
COPY ./start /

CMD ["/start"]
