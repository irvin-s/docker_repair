FROM timpark/ubuntu
MAINTAINER Tim Park <tpark@microsoft.com>

RUN sudo apt-get install -y software-properties-common python-software-properties
RUN sudo add-apt-repository ppa:chris-lea/node.js
RUN sudo apt-get update
RUN sudo apt-get install -y nodejs
RUN sudo npm install npm -g
