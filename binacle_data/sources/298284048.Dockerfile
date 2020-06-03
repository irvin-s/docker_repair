FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-eth-tnt-tx-service/package.json node-eth-tnt-tx-service/yarn.lock /home/node/app/
RUN yarn

COPY node-eth-tnt-tx-service/lib /home/node/app/lib
COPY node-eth-tnt-tx-service/server.js /home/node/app/

CMD ["yarn", "start"]
