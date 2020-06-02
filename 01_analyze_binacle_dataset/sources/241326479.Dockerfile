# Node.js v7.7
#
# docker run --rm -it supinf/node:7.7 node --version
# docker run --rm -it supinf/node:7.7 node --help

FROM node:7.7.1-alpine

RUN apk --no-cache add tini

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "-h"]
