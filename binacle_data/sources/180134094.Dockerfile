FROM nginx:alpine
MAINTAINER Spring Signage <info@springsignage.com>

COPY ./output /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
ADD https://raw.githubusercontent.com/xibosignage/xibo-cms/master/web/swagger.json /usr/share/nginx/html/swagger.json
RUN chmod 544 /usr/share/nginx/html/swagger.json