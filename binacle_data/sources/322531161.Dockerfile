FROM yodebu/emurgis:1.0.2
MAINTAINER Debapriya Das (yodebu@gmail.com)
RUN selenium-standalone start &
EXPOSE 4444/tcp

WORKDIR /root
RUN /usr/bin/git clone https://github.com/EmurgoHK/Emurgis emurgis
WORKDIR /root/emurgis
RUN ls -alh
RUN meteor npm install
RUN meteor npm install --unsafe wdio-mocha-framework webdriverio assert
RUN meteor &
RUN sleep 300 # wait for Meteor to start, it takes some time, 5 minutes should be sufficient
       
RUN ./node_modules/.bin/wdio wdio.conf.js # client side tests with wdio
RUN meteor test --driver-package=meteortesting:mocha --once --port 5000 # unit tests

