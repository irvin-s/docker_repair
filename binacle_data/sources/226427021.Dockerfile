# Docker best practices/commands:
# https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/

FROM hewlettpackardenterprise/core-hubot:latest

ARG http_proxy
ARG https_proxy

COPY docker_entry.sh /usr/local/bin/
COPY docker_go.sh /go.sh
COPY . /home/docker/hubot-org/

WORKDIR /home/docker/hubot

RUN npm install hubot-hipchat
RUN npm install hubot-conversation

WORKDIR /home/docker/hpe-oneview-hubot

RUN cp -rf /home/docker/hubot-core-org/node_modules/ /home/docker/hpe-oneview-hubot/

COPY gulpfile.js /home/docker/hpe-oneview-hubot/
COPY src /home/docker/hpe-oneview-hubot/src/

ENTRYPOINT ["sh", "/usr/local/bin/docker_entry.sh"]
