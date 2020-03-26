FROM node
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

RUN npm install -g chai abao
WORKDIR /raml
VOLUME /raml

ENV LOOP_DELAY=15

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

CMD /init.sh
