FROM node:6.5.0-slim

RUN npm install newman@2

ENTRYPOINT ["/node_modules/.bin/newman"]
