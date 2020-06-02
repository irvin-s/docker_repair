# Note! If you make changes it in this file, to rebuild it use:
#   docker-compose build ui
#

FROM node:9

ADD ui/package.json /package.json
ADD ui/yarn.lock /yarn.lock
RUN yarn

ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin

WORKDIR /app
ADD ui /app

EXPOSE 3000
EXPOSE 35729

ENTRYPOINT ["/bin/bash", "/app/run.sh"]

CMD ["start"]
