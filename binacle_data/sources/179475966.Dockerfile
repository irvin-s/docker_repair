FROM node:4.2
MAINTAINER Josh Finnie <josh@jfin.us>

RUN npm install -g gulp@3.8.10 bower@1.3.12 node-sass@3.4.2

WORKDIR /code/

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD ["/usr/local/bin/run"]
