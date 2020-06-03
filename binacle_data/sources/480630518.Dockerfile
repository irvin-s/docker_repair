FROM node:5.9.0-wheezy

RUN useradd --user-group --create-home --shell /bin/false app
# TODO: && npm install --global npm@3.8.2

ENV HOME=/home/app

COPY package.json npm-shrinkwrap.json $HOME/src/
RUN chown -R app:app $HOME/*

USER app
WORKDIR $HOME/src
RUN npm install && npm cache clean
