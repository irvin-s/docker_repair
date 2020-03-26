### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/nodejs:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ADD . /srv/app
WORKDIR /srv/app
RUN npm install
EXPOSE 80
ENTRYPOINT ["node", "index.js"]