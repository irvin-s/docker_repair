FROM mhart/alpine-node:5

ADD . /github-trending-api
WORKDIR /github-trending-api
RUN npm install --production

CMD ./bin/github-trending-api
