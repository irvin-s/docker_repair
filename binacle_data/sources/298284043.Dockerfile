FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-btc-mon-service/package.json node-btc-mon-service/yarn.lock /home/node/app/
RUN yarn

COPY node-btc-mon-service/server.js /home/node/app/

CMD ["yarn", "start"]
