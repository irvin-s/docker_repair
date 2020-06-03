FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-audit-producer-service/package.json node-audit-producer-service/yarn.lock /home/node/app/
RUN yarn

COPY node-audit-producer-service/server.js /home/node/app/

CMD ["yarn", "start"]
