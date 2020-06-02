FROM quay.io/modcloth/nodejs-dev:latest
MAINTAINER Dan Buch <d.buch@modcloth.com>

RUN npm install -g 'hubot@2.6.3' 'hubot-scripts@2.5.6'
