FROM nginx:stable-alpine

LABEL maintainer="Andriy Kornatskyy <andriy.kornatskyy@live.com>"

ENV NODE_ENV=prod

RUN set -ex \
    \
    && apk add --no-cache --virtual .build-deps \
        nodejs \
        npm \
        git \
    \
    && git clone --depth=1 https://github.com/akornatskyy/sample-blog-react-reflux.git src \
    \
    && cd src \
    && npm i \
    \
    && npm run build \
    && mv dist/* /usr/share/nginx/html \
    \
    && rm -rf /src ~/.npm /tmp/npm-* \
    && apk del .build-deps

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
