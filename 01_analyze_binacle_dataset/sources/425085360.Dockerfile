# NodeJS GulpJS Ruby (gewo/ngr)
FROM gewo/ruby
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN apt-get update && \
  apt-get -y install software-properties-common curl git

# Install NodeJS
RUN add-apt-repository ppa:chris-lea/node.js && \
  apt-get update && \
  sudo apt-get -y install nodejs && \
  apt-get clean

RUN npm install -g gulp

CMD ["/bin/bash"]
