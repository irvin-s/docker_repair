FROM node
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

RUN npm install -g osprey-mock-service
WORKDIR /raml
VOLUME /raml

ENV RAML_PATH=api.raml

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 80
CMD /init.sh
