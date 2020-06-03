FROM knitpk/api-admin:latest as api-admin

ARG ADMIN_PUBLIC_URL='/admin'
ARG ADMIN_API_URL='http://localhost'
ENV PUBLIC_URL=${ADMIN_PUBLIC_URL} \
    REACT_APP_API_URL=${ADMIN_API_URL}

RUN ASSETS_VERSION=$(cat build/asset-manifest.json | grep "\"main.js\"" | sed -E "s/\s+\"main.js\": \"static\/js\/main\.(.*)\.js\",/\1/") && \
    dockerize -delims "{{{:}}}" \
      -template build/index.html.tmpl:build/index.html \
      -template build/service-worker.js.tmpl:build/service-worker.js \
      -template build/static/js/main.$ASSETS_VERSION.js.tmpl:build/static/js/main.$ASSETS_VERSION.js \
      -template build/static/js/main.$ASSETS_VERSION.js.map.tmpl:build/static/js/main.$ASSETS_VERSION.js.map


FROM alpine:3.7

COPY docker-app-start.sh /usr/local/bin/docker-app-start
RUN apk add --no-cache nginx && \
    chmod +x /usr/local/bin/docker-app-start

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf/* /etc/nginx/conf.d/
COPY --from=api-admin /usr/src/app/build /usr/src/api/public/admin

ENV PORT 80
ENV API_URL http://api
CMD ["docker-app-start"]
