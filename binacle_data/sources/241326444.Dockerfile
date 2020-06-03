# Mermade/check_api v1.2
# docker run --rm -v $(pwd):/work supinf/check-api:1.2 /work/spec.yaml

FROM node:11.9.0-alpine

ENV CHECKAPI_VERSION=1.2.2

RUN apk --no-cache add --virtual build-deps git \
    && git clone --depth=1 -b "v${CHECKAPI_VERSION}" https://github.com/Mermade/check_api.git /code \
    && apk del --purge -r build-deps \
    && cd /code \
    && yarn add "node-fetch" \
    && rm -rf /usr/local/share/.cache \
       /code/node_modules/raml-1-parser/documentation/images \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
