FROM mhart/alpine-node:base-0.10.40
MAINTAINER Tiago Soares <mr.tiagosoares@gmail.com>

ADD src .

EXPOSE 3000
CMD ["node", "webserver.js"]
