FROM base-nginx

LABEL maintainer="Webber Takken <webber@takken.io>"

COPY nginx.conf /etc/nginx/
COPY symfony.conf /etc/nginx/conf.d/

COPY ./dist /var/www/app

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
