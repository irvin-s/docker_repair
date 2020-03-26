FROM node:8-alpine

LABEL com.altoros.version="0.12.1"

# Create app directory
WORKDIR /usr/src/app
COPY . .

RUN apk add --update python make alpine-sdk libc6-compat \
&& npm install && npm cache rm --force \
   # remove node-gyp dependencies (for alpine only)
   # libc6-compat is essential for grpc, so don't remove it
&& apk del --purge python make alpine-sdk

EXPOSE 4000

CMD [ "npm", "start" ]