FROM node:6.9.1
ADD . /app
ENV NODE_ENV production
WORKDIR /app
RUN apt-get update \
    && apt-get install -y libstdc++-4.9-dev
RUN npm install bower -g
RUN npm install --unsafe-perm
CMD node teambot.js --mongo mongodb://mongo:27017 --production
