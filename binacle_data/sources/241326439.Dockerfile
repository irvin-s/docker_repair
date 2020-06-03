# AsyncAPI Docgen v1.10
# docker run --rm supinf/asyncapi-docgen:1.10
# docker run --rm -v $(pwd):/spec supinf/asyncapi-docgen:1.10 spec.yaml

FROM node:11.9.0-alpine

ENV ASYNCAPI_DOCGEN_VERSION=1.10.6

RUN yarn global add "asyncapi-docgen@${ASYNCAPI_DOCGEN_VERSION}" \
    && rm -rf /usr/local/share/.cache \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

WORKDIR /spec

ENTRYPOINT [ "asyncapi-docgen" ]
CMD ["--version"]
