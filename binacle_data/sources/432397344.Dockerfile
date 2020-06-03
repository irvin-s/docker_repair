FROM node:0.10
MAINTAINER Outsider <outsideris@gmail.com>

COPY ./src/ /src
RUN cd /src; npm install

EXPOSE  3000

CMD ["/src/bin/express"]
