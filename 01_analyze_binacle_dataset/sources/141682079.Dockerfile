FROM ubuntu:14.04
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y nodejs
RUN npm install -g httpserver
RUN mkdir -p data
RUN cd data
RUN echo "hello" >index.html

VOLUME ["/data"]
WORKDIR ["/data"]
EXPOSE 8080

CMD httpserver
