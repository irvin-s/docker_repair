FROM node:10.10.0 as builder

LABEL maintainer="Raincal <cyj94228@gmail.com>"

WORKDIR /app

COPY . /app

RUN yarn

RUN yarn build

FROM nginx:1.15.3-alpine

COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/nginx.conf /etc/nginx
