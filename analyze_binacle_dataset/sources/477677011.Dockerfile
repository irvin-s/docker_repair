FROM node:9

ADD yarn.lock /app/yarn.lock
ADD package.json /app/package.json
ADD run.sh /app/run.sh
ADD client /app/client
ADD backend /app/backend

ENV NODE_PATH=/app/node_modules
ENV PATH=$PATH:/app/node_modules/.bin

WORKDIR /app

RUN yarn install

EXPOSE 3000
EXPOSE 5000
EXPOSE 35729

ENTRYPOINT ["/bin/bash", "/app/run.sh"]
CMD ["dev"]
