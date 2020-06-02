FROM node

RUN useradd -c 'hubot' -m -d /home/hubot -s /bin/bash hubot
# RUN mkdir /home/hubot/hubots
RUN npm install -g coffee-script yo generator-hubot hubot
RUN npm install -g jasmine-node
USER hubot
ENV HOME /home/hubot
WORKDIR /home/hubot
ENV PATH $PATH:/usr/local/hubot-utils
