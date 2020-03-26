FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-task-accumulator-service/package.json node-task-accumulator-service/yarn.lock /home/node/app/
RUN yarn

COPY node-task-accumulator-service/server.js /home/node/app/

CMD ["yarn", "start"]
