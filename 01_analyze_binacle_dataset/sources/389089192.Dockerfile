FROM instructure/node:latest
# this should be pinned to node 0.12.7 once that tag exists

USER root

ENV APP_HOME /usr/src/app/
RUN mkdir -p $APP_HOME && chown -R docker:docker $APP_HOME
WORKDIR $APP_HOME

USER docker
EXPOSE 2992

CMD ["npm", "run", "start"]
