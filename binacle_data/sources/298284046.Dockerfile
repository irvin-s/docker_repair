FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-eth-contracts/package.json node-eth-contracts/yarn.lock /home/node/app/
RUN yarn

COPY node-eth-contracts/build /home/node/app/build/
COPY node-eth-contracts/contracts /home/node/app/contracts/
COPY node-eth-contracts/migrations /home/node/app/migrations/
COPY node-eth-contracts/scripts /home/node/app/scripts/
COPY node-eth-contracts/test /home/node/app/test/
COPY node-eth-contracts/truffle.js /home/node/app/

CMD ["yarn", "migrate"]
