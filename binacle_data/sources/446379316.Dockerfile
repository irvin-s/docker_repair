FROM nginx

ENV WEB_SITE your-blog.site

RUN mkdir -p /etc/nginx/ssl/${WEB_SITE}

COPY copy/nginx.pem /etc/nginx/ssl/${WEB_SITE}/nginx.pem
COPY copy/nginx.key /etc/nginx/ssl/${WEB_SITE}/nginx.key
COPY copy/nginx.conf /etc/nginx/nginx.conf

LABEL description="SSL & Ghost" \
      maintainer="imlooke <lwx12525@outlook.com>"

EXPOSE 80
EXPOSE 443
CMD nginx -g 'daemon off;'