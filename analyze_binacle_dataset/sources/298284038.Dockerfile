FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-aggregator-service/package.json node-aggregator-service/yarn.lock /home/node/app/
RUN yarn

COPY node-aggregator-service/server.js /home/node/app/

CMD ["yarn", "start"]
