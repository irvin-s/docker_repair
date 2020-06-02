FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

COPY node-calendar-service/package.json node-calendar-service/yarn.lock /home/node/app/
RUN yarn

COPY node-calendar-service/server.js /home/node/app/

CMD ["yarn", "start"]
