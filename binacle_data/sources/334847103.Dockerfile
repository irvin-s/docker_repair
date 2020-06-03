FROM node
# FROM mhart/alpine-node:base
# FROM mhart/alpine-node:base-0.10

# Install PM2
RUN npm install -g pm2

WORKDIR /gameserver
ADD . .

# If you need npm, don't use a base tag
RUN npm install

EXPOSE 4000
CMD pm2 start --no-daemon  server.js