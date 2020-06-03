FROM mhart/alpine-node
# FROM mhart/alpine-node:base
# FROM mhart/alpine-node:base-0.10

WORKDIR /src
ADD . .
# If you have native dependencies, you'll need extra tools

RUN apk add --update make gcc g++ python
# If you need npm, don't use a base tag
RUN npm install
# If you had native dependencies you can now remove build tools
RUN apk del make gcc g++ python && \
  rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

EXPOSE 3000
CMD ["npm", "start"]
