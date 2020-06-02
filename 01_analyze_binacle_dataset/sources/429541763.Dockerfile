FROM node:8
COPY . /usr/src/app/
WORKDIR /usr/src/app

RUN useradd --home-dir /usr/src/app bot
RUN chown -R bot:bot /usr/src/app
VOLUME /usr/src/app/conf
VOLUME /usr/src/app/data

USER bot
RUN yarn install

CMD ["node", "--max_old_space_size=350", "index.js"]
