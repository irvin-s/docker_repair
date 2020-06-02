# check .circleci/config.yml version
FROM node:9.5.0

WORKDIR /graphql
COPY .build/ .build/
COPY node_modules/ node_modules/

EXPOSE 3000
CMD ["node", "/graphql/.build/src/index.js"]
