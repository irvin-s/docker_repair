FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-btc-tx-service/package.json node-btc-tx-service/yarn.lock /home/node/app/
RUN yarn

COPY node-btc-tx-service/server.js /home/node/app/

CMD ["yarn", "start"]
