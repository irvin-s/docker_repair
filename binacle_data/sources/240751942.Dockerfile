FROM node:10.6.0-alpine
MAINTAINER Stafford Brunk <stafford.brunk@gmail.com>
LABEL version='7.6.0'
LABEL description='Heroku CLI packaged on alpine linux'

ENV HEROKU_CLI_VERSION '7.6.0'
RUN yarn global add heroku@$HEROKU_CLI_VERSION

ENTRYPOINT ["/usr/local/bin/heroku"]
