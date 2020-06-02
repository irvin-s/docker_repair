FROM node as builder
LABEL maintainer="Nazar Mokrynskyi <nazar@mokrynskyi.com>"

COPY audio /code/audio
COPY css /code/css
COPY html /code/html
COPY img /code/img
COPY js /code/js
COPY gulpfile.js /code/
COPY favicon.ico /code/
COPY index.html /code/
COPY manifest.json /code/
COPY package.json /code/

RUN cd /code && npm install && mkdir dist && node_modules/.bin/gulp

# This is basically a hack, since we use docker container in gulp build and can't call it inside of another docker container during build process
FROM nazarpc/subset-font as font-builder
LABEL maintainer="Nazar Mokrynskyi <nazar@mokrynskyi.com>"
COPY --from=builder /code/dist/fa-solid-900.woff2 /font.woff2
COPY --from=builder /code/dist/index.min.html /style.css

RUN php subset.php

FROM nginx:alpine
LABEL maintainer="Nazar Mokrynskyi <nazar@mokrynskyi.com>"

COPY --from=builder /code/dist /usr/share/nginx/html/dist
COPY --from=font-builder /font.woff2 /usr/share/nginx/html/dist/fa-solid-900.woff2
COPY --from=builder /code/favicon.ico /usr/share/nginx/html/
COPY --from=builder /code/index.html /usr/share/nginx/html/
COPY --from=builder /code/sw.min.js /usr/share/nginx/html/

RUN \
	apk update && \
	apk upgrade && \
	rm -rf /var/cache/apk/*

RUN sed -i 's/}/    application\/wasm                                 wasm;\n}/g' /etc/nginx/mime.types
RUN sed -i 's/access_log.\+;/access_log off;/g' /etc/nginx/nginx.conf
