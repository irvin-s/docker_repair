FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

# Define and install dependencies
COPY node-proof-state-service/package.json node-proof-state-service/yarn.lock /home/node/app/
RUN yarn

COPY node-proof-state-service/server.js /home/node/app/

CMD ["yarn", "start"]
