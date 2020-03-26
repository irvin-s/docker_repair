# Newman v3.9
#
# docker run --rm -it -v $(pwd):/app supinf/newman:3.9 run collection.json

FROM alpine:3.7

ENV NEWMAN_VERSION=3.9.4 \
    NODE_VERSION=8.9.3-r1

RUN apk --no-cache add nodejs-npm=${NODE_VERSION} \
    && : Install Newman \
    && npm install --global "newman@${NEWMAN_VERSION}" \
    && : Clean up \
    && rm -rf /root/.npm \
       /usr/lib/node_modules/newman/node_modules/postman-collection-transformer/examples \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

WORKDIR /app

ENTRYPOINT ["newman"]
CMD ["run", "--help"]
