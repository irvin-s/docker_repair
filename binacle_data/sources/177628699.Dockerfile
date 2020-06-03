FROM node:0.10
MAINTAINER Yuanhsiang Cheng <lyforever62@hotmail.com>
EXPOSE 5555

RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN echo 'Asia/Taipei' > /etc/timezone

ADD . /app
WORKDIR /app
RUN npm install || exit 0
CMD node startups.js