# FROM mhart/alpine-node:10.7.0 as test
# WORKDIR /usr/src/app
# COPY . .
# RUN yarn install
# RUN yarn test

FROM mhart/alpine-node:10.7.0 as build
WORKDIR /usr/src/app
COPY package.json .
COPY yarn.lock .
RUN yarn install --production

FROM mhart/alpine-node:base-10.7.0
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/node_modules node_modules
COPY . .
CMD [ "node", "src/index.js" ]
