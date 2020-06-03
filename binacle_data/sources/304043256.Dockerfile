FROM nginx

COPY ./docker/ui-admin.conf /etc/nginx/conf.d/default.conf

COPY ./dist  /usr/share/nginx/html/pings-ui-admin

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
