# Node.js v7.2
#
# docker run --rm -it supinf/node:7.2 node --version
# docker run --rm -it supinf/node:7.2 node --help

FROM alpine:3.5

ENV NODE_VERSION=7.2.1-r1

RUN apk --no-cache add tini nodejs-current=${NODE_VERSION} \

    # Clean up
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "-h"]
