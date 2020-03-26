# Docker best practices/commands:
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

FROM alpine:3.5

RUN adduser -Ds /bin/bash docker

###############################################################################
USER docker
COPY . /home/docker/hubot-core-org/
RUN mkdir -p /home/docker/hubot/node_modules
RUN chmod 777 /home/docker/hubot/
RUN chmod 777 /home/docker/hubot/node_modules
WORKDIR /home/docker/hubot

###############################################################################
USER root

#http://askubuntu.com/questions/506158/unable-to-initialize-frontend-dialog-when-using-ssh
ENV DEBIAN_FRONTEND=noninteractive

ARG http_proxy
ARG https_proxy

# Steps from:
# https://github.com/HewlettPackard/hpe-oneview-hubot/wiki/Getting-Started

# 1. Clone repo

# 2. Install node.js + npm (etc.)
RUN apk --no-cache add \
    curl                                \
    libcurl                             \
    sudo                                \
    bash                                \
    php5-curl
#RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
#RUN apk add --no-cache aptitude
#RUN aptitude install -y
RUN apk --no-cache add \
    jq                  \
    nodejs

RUN npm config set proxy $http_proxy
RUN npm config set http-proxy $http_proxy
RUN npm config set https-proxy $http_proxy


# 3. Install Hubot

RUN npm install -g yo generator-hubot css-what css-select

###############################################################################
USER docker

RUN npm config set proxy $http_proxy
RUN npm config set http-proxy $http_proxy
RUN npm config set https-proxy $http_proxy


RUN echo "n" | yo hubot --defaults --name="bot" --adapter=slack

###############################################################################
USER root

# Avoid warnings for deprecated dependencies:
RUN npm install -g minimatch@^3.0.2;      \
    npm install -g graceful-fs@^4.0.0;

RUN npm install gulp;                     \
    npm install gulp-task-listing@^1.0.1;

# To install avoid cross-device link not permitted...
RUN cd /usr/lib/node_modules/npm; npm install fs-extra;        \
    sed -i -e s/graceful-fs/fs-extra/ -e s/fs.rename/fs.move/ ./lib/utils/rename.js

###############################################################################
USER docker


RUN npm install hubot@2.x                \
    amqp@^0.2.6                          \
    d3@^4.2.7                            \
    jsdom@^9.8.0                         \
    svg2png@^4.0.0                       \
    fuzzyset.js@0.0.1                    \
    nlp_compromise@^6.5.0                \
    request@^2.75.0                      \
    request-promise@^4.1.1;


RUN npm install del@^2.2.2;

###############################################################################
USER root

# 4. Install gulp (etc.)

WORKDIR /home/docker/hubot-core-org

# To install avoid cross-device link not permitted...
RUN cd /usr/lib/node_modules/npm; npm install fs-extra;        \
    sed -i -e s/graceful-fs/fs-extra/ -e s/fs.rename/fs.move/ ./lib/utils/rename.js

# Avoid warnings for deprecated dependencies:
RUN npm install minimatch@^3.0.2;   \
    npm install graceful-fs@^4.0.0;

RUN npm install -g gulp;                  \
    npm install;                          \
    npm install gulp;                     \
    npm install gulp-task-listing@^1.0.1; \
    npm install gulp-util@^3.0.7

RUN npm install hubot@2.x                \
    amqp@^0.2.6                          \
    d3@^4.2.7                            \
    jsdom@^9.8.0                         \
    svg2png@^4.0.0                       \
    fuzzyset.js@0.0.1                    \
    nlp_compromise@^6.5.0                \
    request@^2.75.0                      \
    request-promise@^4.1.1               \
    del@^2.2.2;


# 5. Copy config file
# 6. Update IP (docker_run.sh handles this)
# 7. Run gulp watch (docker_go.sh handles this, called by docker_run.sh)
# 8. Run bin/hubot (docker_go.sh handles this, called by docker_run.sh)
# 9. Test your bot (instructions presented by docker_go.sh)

COPY docker_entry.sh /usr/local/bin/
COPY docker_go.sh /go.sh

ENTRYPOINT ["sh", "/usr/local/bin/docker_entry.sh"]
