FROM node:6.10.3

USER node
RUN mkdir ~/.npm-global && npm config set prefix '~/.npm-global' && export PATH=~/.npm-global/bin:$PATH

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

EXPOSE 3000
EXPOSE 5858

CMD npm start
