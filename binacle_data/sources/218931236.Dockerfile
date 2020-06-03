FROM ubuntu:14.04

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository ppa:chris-lea/node.js
RUN apt-get update && apt-get install -y nodejs

RUN npm install -g elasticdump

ADD import.sh /import.sh
ADD export.sh /export.sh

CMD /bin/bash
