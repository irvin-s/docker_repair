FROM node:7

WORKDIR /home/node

# needed for killall command
# current workaground for stoping all servers
# in CI context (killall node ruby)
RUN apt-get update -qq \
    && apt-get install -y psmisc

COPY . /home/node

RUN npm install
RUN npm run build
RUN npm link
