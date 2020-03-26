FROM nginx:alpine

RUN apk add --update --no-cache tzdata && cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime

COPY www /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

# nginx cache
RUN mkdir -p /var/cache/nginx/client_temp
RUN mkdir -p /var/cache/nginx/fastcgi_temp
RUN mkdir -p /var/cache/nginx/proxy_temp
RUN mkdir -p /var/cache/nginx/uwsgi_temp

# nginx logs
RUN mkdir -p /var/log/nginx
RUN touch /var/log/nginx/error.log
RUN touch /var/log/nginx/access.log

# support running as arbitrary user which belogs to the root group
RUN chmod -R a+rwx /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html
RUN chmod a+rwx /docker-entrypoint.sh

EXPOSE 8080

RUN addgroup nginx root
USER nginx

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
