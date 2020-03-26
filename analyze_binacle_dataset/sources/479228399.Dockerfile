FROM node:10

LABEL "com.github.actions.name"="Github Deployment"
LABEL "com.github.actions.description"="Push release note to S3"
LABEL "com.github.actions.icon"="bookmark"
LABEL "com.github.actions.color"="green"

RUN mkdir -p /app
ADD package.json yarn.lock /app/
RUN cd /app && yarn --pure-lockfile
ADD . /app

ENTRYPOINT ["/app/release"]
