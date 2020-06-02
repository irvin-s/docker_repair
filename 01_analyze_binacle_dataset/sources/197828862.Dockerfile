FROM node:6

ENV HOME=/code
ENV NPM_CONFIG_LOGLEVEL warn

COPY package.json $HOME/

WORKDIR $HOME

RUN npm install

COPY . $HOME/

EXPOSE 8080

CMD ["npm", "run", "dev"]
