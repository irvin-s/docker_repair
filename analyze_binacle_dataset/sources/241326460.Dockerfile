# Newman v4.1
#
# docker run --rm -it -v $(pwd):/app supinf/newman:4.1 run collection.json

FROM alpine:3.8

ENV NEWMAN_VERSION=4.1.0 \
    NODE_VERSION=8.11.4-r0

RUN apk --no-cache add nodejs=${NODE_VERSION} \
    && : Install Newman \
    && apk --no-cache add --virtual build-deps npm=${NODE_VERSION} \
    && npm install --global "newman@${NEWMAN_VERSION}" \
    && : Clean up \
    && apk del --purge -r build-deps \
    && rm -rf /root/.npm \
       /usr/lib/node_modules/newman/node_modules/postman-collection-transformer/examples \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

WORKDIR /app

ENTRYPOINT ["newman"]
CMD ["run", "--help"]
