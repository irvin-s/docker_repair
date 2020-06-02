FROM mhart/alpine-node:latest
MAINTAINER Christoph Wiechert <wio@psitrax.de>

RUN npm install -g docker-etcd-registrator

CMD ["docker-etcd-registrator"]