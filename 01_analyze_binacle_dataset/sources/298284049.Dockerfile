FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-nist-beacon-service/package.json node-nist-beacon-service/yarn.lock /home/node/app/
RUN yarn

COPY node-nist-beacon-service/server.js /home/node/app/

CMD ["yarn", "start"]
