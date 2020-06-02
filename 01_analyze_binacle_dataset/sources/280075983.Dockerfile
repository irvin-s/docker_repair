ARG KNIT_API_TAG
ARG KNIT_API_ADMIN_TAG

FROM knitpk/api-admin:${KNIT_API_ADMIN_TAG} as api-admin

ARG KNTI_API_ADMIN_PUBLIC_URL='/admin'
ARG KNIT_API_ADMIN_API_URL='http://localhost'
ENV PUBLIC_URL=${KNTI_API_ADMIN_PUBLIC_URL} \
    REACT_APP_API_URL=${KNIT_API_ADMIN_API_URL}

RUN ASSETS_VERSION=$(cat build/asset-manifest.json | grep "\"main.js\"" | sed -E "s/\s+\"main.js\": \"static\/js\/main\.(.*)\.js\",/\1/") && \
    dockerize -delims "{{{:}}}" \
      -template build/index.html.tmpl:build/index.html \
      -template build/service-worker.js.tmpl:build/service-worker.js \
      -template build/static/js/main.$ASSETS_VERSION.js.tmpl:build/static/js/main.$ASSETS_VERSION.js \
      -template build/static/js/main.$ASSETS_VERSION.js.map.tmpl:build/static/js/main.$ASSETS_VERSION.js.map


FROM knitpk/api:${KNIT_API_TAG}

RUN apk add --no-cache nginx
COPY deploy/standalone/nginx.conf /etc/nginx/nginx.conf
COPY deploy/standalone/default.conf /etc/nginx/conf.d/default.conf
COPY deploy/standalone/docker-app-entrypoint.sh /usr/local/bin/docker-app-entrypoint
RUN chmod +x /usr/local/bin/docker-app-entrypoint
COPY --from=api-admin /usr/src/app/build /usr/src/api/public/admin

ENV NGINX_PORT 80

HEALTHCHECK --interval=5s --timeout=1s --start-period=1m \
  CMD curl --fail http://127.0.0.1:${NGINX_PORT}/ || exit 1
