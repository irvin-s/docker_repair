FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-task-handler-service/package.json node-task-handler-service/yarn.lock /home/node/app/
RUN yarn

COPY node-task-handler-service/server.js /home/node/app/

CMD ["yarn", "start"]
