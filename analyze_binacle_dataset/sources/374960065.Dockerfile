FROM ubuntu:14.04
MAINTAINER James Turnbull <james@lovedthanlost.net>

RUN apt-get -qqy update
RUN apt-get -qqy install git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node
WORKDIR /opt

# Install reveal.js
RUN git clone https://github.com/hakimel/reveal.js.git presentation
WORKDIR /opt/presentation
RUN npm install -g grunt-cli
RUN npm install
RUN sed -i "s/port: port/port: port,\n\t\t\t\t\thostname: \'\'/g" Gruntfile.js

# Install wetty
RUN git clone https://github.com/krishnasrinivas/wetty
WORKDIR /opt/presentation/wetty
RUN npm install

# Add content
ADD docker.css /opt/presentation/css/theme/docker.css
ADD index.html /opt/presentation/index.html
ADD images /opt/presentation/images/
ADD slides /opt/presentation/slides/

WORKDIR /opt/presentation

EXPOSE 8000

CMD [ "grunt", "serve" ]
