from node:9
label maintainer="michael@brunton-spall.co.uk"
label uk.co.brunton-spall.version="0.0.1-beta"
ARG BOTKIT_STORAGE_POSTGRES_HOST=localhost
ENV token=xoxb-token apitoken=xoxp-apitoken slackdomain=mbs-bot-test.slack.com
copy . /usr/src/xgovslackbot
workdir /usr/src/xgovslackbot
run npm install --only=dev
run BOTKIT_STORAGE_POSTGRES_HOST=$BOTKIT_STORAGE_POSTGRES_HOST npm test
