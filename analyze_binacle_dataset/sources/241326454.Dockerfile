# Mermaid Editor v8.0
# docker run --rm -p 8080:80 supinf/mermaid-editor:8.0
# docker run --rm -p 8080:80 -v $(pwd)/code:/usr/share/nginx/html/code supinf/mermaid-editor:8.0

FROM node:11.9.0-alpine AS build-env

ENV MERMAID_EDITOR_VERSION=8.0.0 \
    MERMAID_EDITOR_COMMIT=574d4847eeed081c9f9f5bf13bd75436551b8ede

RUN apk --no-cache add --virtual build-deps git \
    && git clone https://github.com/mermaidjs/mermaid-live-editor.git app \
    && cd app \
    && git checkout "${MERMAID_EDITOR_COMMIT}" \
    && rm -rf .git \
    && apk del --purge -r build-deps

ADD Edit.js /app/src/components/
ADD utils.js /app/src/

WORKDIR /app
RUN yarn install \
    && rm -rf /usr/local/share/.cache/yarn \
    && find / -depth -type d -name test* -exec rm -rf {} \;

RUN yarn release

FROM nginx:1.15.8-alpine
COPY --from=build-env /app/docs /usr/share/nginx/html
ADD default.mmd /usr/share/nginx/html/code/
