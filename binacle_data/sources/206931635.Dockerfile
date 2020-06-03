# Nametag
#
# VERSION               0.0.1

FROM node
MAINTAINER David Jay <davidgljay@gmail.com>

LABEL description="Used to start the Nametag server"
LABEL updated="10/9/16"
RUN apt-get update
COPY $PWD/.hz /usr/client/.hz
COPY $PWD/.keys /usr/client/.keys
COPY $PWD/dist /usr/client/dist
COPY $PWD/server  /usr/server

WORKDIR usr/server
RUN npm install
RUN npm install -g horizon
CMD bash
