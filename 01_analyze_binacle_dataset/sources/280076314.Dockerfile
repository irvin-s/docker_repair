FROM node:8.6-alpine

RUN apk add --update-cache build-base python git nginx

WORKDIR /app

ENV NODE_ENV development

COPY ./package.json /app/package.json
RUN npm install --quiet

COPY . /app

ENV NODE_ENV production

RUN npm run build

RUN cp -r ./src/assets/* /app/build

# nginx
RUN adduser -D -u 1001 -g 'www' www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /app/build
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig

COPY ./nginx.conf /etc/nginx

EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]