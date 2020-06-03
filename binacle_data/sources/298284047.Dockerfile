FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-eth-tnt-listener-service/package.json node-eth-tnt-listener-service/yarn.lock /home/node/app/
RUN yarn

COPY node-eth-tnt-listener-service/contracts /home/node/app/contracts/
COPY node-eth-tnt-listener-service/server.js /home/node/app/

CMD ["yarn", "start"]
