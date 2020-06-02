FROM nginx:stable-alpine
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# Wrong spelling, will be remove soon.
#---------------
# tools
#---------------
RUN set -ex \
  && apk update && apk add bash
# ------
# config
# ------
# COPY sshd_config /etc/ssh/
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

STOPSIGNAL SIGTERM

ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
