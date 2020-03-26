FROM mhart/alpine-node:6

ENV NPM_CONFIG_LOGLEVEL error
ENV NODE_ENV production

WORKDIR /src
COPY . .

RUN npm install --production

CMD ["node", "index.js"]
