# AsyncAPI Editor v0.x
# docker run --rm -p 3000:3000 supinf/asyncapi-editor:0
# docker run --rm -p 3000:3000 -v $(pwd):/app/public/spec supinf/asyncapi-editor:0

FROM node:11.9.0-alpine

ENV ASYNCAPI_EDITOR_VERSION=0.x \
    ASYNCAPI_EDITOR_COMMIT=35fa6bbd06940c332c02d60a14ef04cc386ecc0b

RUN apk --no-cache add --virtual build-deps git \
    && git clone https://github.com/asyncapi/editor.git app \
    && cd app \
    && git checkout "${ASYNCAPI_EDITOR_COMMIT}" \
    && rm -rf .git \
    && apk del --purge -r build-deps

WORKDIR /app
RUN npm install \
    && npm audit fix \
    && rm -rf /root/.npm/_cacache \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \;

ADD index.js /app/public/
VOLUME ["/app/public/spec"]

ENTRYPOINT [ "npm" ]
CMD ["start"]
