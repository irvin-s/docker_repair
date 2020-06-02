FROM node:10-alpine as builder

WORKDIR /build

COPY package.json .
COPY yarn.lock .

RUN yarn install \
  && yarn cache clean

COPY . .
ENV NODE_ENV production

RUN yarn build


# Working image
FROM alpine:3.7

VOLUME  /usr/share/web-sdk
WORKDIR /usr/share/web-sdk

COPY --from=builder /build/dist /usr/share/web-sdk/

CMD ["/bin/ls", "/usr/share/web-sdk/"]
