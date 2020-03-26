FROM mhart/alpine-node:0.12  
MAINTAINER Maik Hummel <m@ikhummel.com>  
  
WORKDIR /opt/youtransfer/  
  
ENV YOUTRANSFER_VERSION=1.0.6  
RUN apk add --no-cache git && \  
npm i -g youtransfer@${YOUTRANSFER_VERSION} && \  
youtransfer init && \  
npm i  
  
VOLUME /opt/youtransfer/uploads  
VOLUME /opt/youtransfer/config  
  
CMD npm run dockerized  
  
EXPOSE 5000  

