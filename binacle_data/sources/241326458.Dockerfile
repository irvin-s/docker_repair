# Newman v3.5
#
# docker run --rm -it -v $(pwd):/app supinf/newman run collection.json

FROM alpine:3.5

ENV NEWMAN_VERSION=3.5.2 \
    NODE_VERSION=7.2.1-r1


RUN apk --no-cache add nodejs-current=${NODE_VERSION} \

    # Install Newman
    && npm install --global "newman@${NEWMAN_VERSION}" \

    # Clean up
    && rm -rf /root/.npm \
    && rm -rf /usr/lib/node_modules/newman/node_modules/postman-collection-transformer/examples \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

WORKDIR /app

ENTRYPOINT ["/usr/bin/newman"]
CMD ["run", "--help"]
