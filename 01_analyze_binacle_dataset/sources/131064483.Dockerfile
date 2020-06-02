FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY ./EU4.Stats.Web/client/ /usr/share/nginx/html
VOLUME /tmp
VOLUME /usr/share/nginx/html/games
