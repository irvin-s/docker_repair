FROM node:11.10 as base

WORKDIR /provendocs

ADD . .

RUN yarn install && \
    yarn build

FROM node:11.10-alpine

WORKDIR /provendocs

COPY --from=base /provendocs/node_modules /provendocs/node_modules
COPY --from=base /provendocs/bin /provendocs/bin
COPY --from=base /provendocs/dist /provendocs/dist