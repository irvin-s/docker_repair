FROM node:10.15.1-alpine

ARG WEBAPP_NAME
ARG WEBAPP_PORT

# setup a user so as not to run as root
# see: https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md#non-root-user
RUN adduser -S wellcomecollection
ENV HOME=/home/wellcomecollection
USER wellcomecollection
WORKDIR $HOME/

COPY ./${WEBAPP_NAME}/app/.dist ./
COPY ./build/pm2_webapp.yml ./pm2.yml
RUN sed -i "s/WEBAPP_NAME/${WEBAPP_NAME}/g" ./pm2.yml
RUN yarn add pm2

EXPOSE ${WEBAPP_PORT}
CMD ["./node_modules/.bin/pm2-docker", "start", "pm2.yml"]
