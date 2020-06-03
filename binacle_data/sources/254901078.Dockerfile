FROM node:8.11-alpine
WORKDIR /app
RUN apk add --no-cache git
ENV AGENT_CONFIG_PATH /config/config.js
ENV DOCKER true
ADD package.json /app
RUN yarn install
ADD app.js .
CMD ["yarn","start"]
