FROM node:10.13-alpine

WORKDIR /app

COPY .git /.git
COPY client/ .
COPY misc/ /misc

RUN apk add --no-cache git

RUN rm -rf node_modules/

RUN npm install
RUN npm run build

###

FROM nginx:alpine

COPY --from=0 /app /app

COPY docker/production/nginx/nginx.conf /app/nginx.conf
CMD envsubst '\$APP_DOMAIN' < /app/nginx.conf > /etc/nginx/nginx.conf && nginx -g 'daemon off;'

