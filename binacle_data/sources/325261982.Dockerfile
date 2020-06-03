FROM node:8

USER node

RUN mkdir /home/node/.npm-global
ENV PATH=/home/node/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

ENV HOME=/home/node

WORKDIR $HOME/app

RUN npm i -g npm

RUN npm install -g @angular/cli && npm cache clean --force

EXPOSE 4200

CMD [ "node" ]