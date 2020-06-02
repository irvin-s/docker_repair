### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

RUN apk add  -U apache2-utils
RUN rm -rf /var/cache/apk/*