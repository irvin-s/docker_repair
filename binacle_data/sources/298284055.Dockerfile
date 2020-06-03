FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-tnt-reward-service/package.json node-tnt-reward-service/yarn.lock /home/node/app/
RUN yarn

COPY node-tnt-reward-service/server.js /home/node/app/

CMD ["yarn", "start"]
