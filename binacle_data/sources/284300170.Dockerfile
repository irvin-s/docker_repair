# ビルド環境
FROM node:11.11.0-alpine as build
WORKDIR /app
RUN apk add --no-cache git
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 本番環境
FROM abiosoft/caddy:0.11.5-no-stats
EXPOSE 80
COPY ./docker/caddy/Caddyfile /etc/Caddyfile
COPY --from=build /app/dist /usr/share/caddy/html
