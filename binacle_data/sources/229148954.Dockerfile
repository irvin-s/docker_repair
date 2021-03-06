FROM instructure/node:10
USER root

ENV YARN_VERSION 1.16.0
ENV DOCKER_HOME /home/docker
ENV APP_HOME /usr/src/app
ENV YARN_CACHE $DOCKER_HOME/.cache/yarn

## Add Chrome and ssh
RUN curl --silent "https://dl-ssl.google.com/linux/linux_signing_key.pub" | apt-key add - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" > "/etc/apt/sources.list.d/google.list" \
 && apt-get update --quiet=2 \
 && apt-get install --quiet=2 --no-install-recommends --yes \
      google-chrome-beta \
      libgconf-2-4 \
      ssh \
      > /dev/null \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## Add Yarn
## RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  ## && echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list \
  ## && apt-get update --quiet=2 \
  ## && apt-get install --quiet=2 --allow-downgrades --no-install-recommends --yes \
    ## yarn="$YARN_VERSION" \
  ## && apt-get clean \
  ## && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER docker

RUN mkdir -p $APP_HOME/
WORKDIR $APP_HOME/

RUN mkdir -p $YARN_CACHE
RUN yarn config set no-progress true \
 && yarn config set cache-folder $YARN_CACHE


COPY --chown=docker:docker .yarnrc package.json yarn.lock $APP_HOME/

RUN yarn --ignore-scripts --frozen-lockfile

COPY --chown=docker:docker . $APP_HOME/
