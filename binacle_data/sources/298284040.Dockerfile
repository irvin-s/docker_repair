FROM gcr.io/chainpoint-registry/github-chainpoint-chainpoint-services/node-base

COPY node-lib/lib /home/node/app/lib

# Define and install dependencies
COPY node-api-service/package.json node-api-service/yarn.lock /home/node/app/
RUN yarn

RUN mkdir /home/node/app/lib/endpoints
COPY node-api-service/lib/endpoints /home/node/app/lib/endpoints/

COPY node-api-service/server.js /home/node/app/

EXPOSE 8080

CMD ["yarn", "start"]
