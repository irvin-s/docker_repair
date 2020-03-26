FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-proof-gen-service/package.json node-proof-gen-service/yarn.lock /home/node/app/
RUN yarn

COPY node-proof-gen-service/server.js /home/node/app/

CMD ["yarn", "start"]
