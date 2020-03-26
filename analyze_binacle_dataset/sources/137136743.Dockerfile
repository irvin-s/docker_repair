FROM ubuntu

ENV TERM linux
RUN apt-get update -y
RUN apt-get install haproxy golang tmux curl git iptables -y

RUN mkdir /app
WORKDIR /app
ADD . /app/

ADD haproxy /etc/default/haproxy
ADD haproxy.cfg /etc/haproxy/haproxy.cfg
EXPOSE 9000
