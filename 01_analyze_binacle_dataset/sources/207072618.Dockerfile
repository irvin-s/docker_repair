FROM unocha/alpine-base-nginx-extras:%%UPSTREAM%%

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-nginx-extras" \
      org.label-schema.description="This service provides an nginx platform with uploadprogress module." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.9" \
      info.humanitarianresponse.nginx=$VERSION \
      info.humanitarianresponse.nginx.modules="ssl realip addition sub sav flv mp4 gunzip gzip_static random_index secure_link stub_status auth_request threads stream ssl slice file-aio http_v2 uploadprogress"

COPY nginx.conf default.conf index.html run_nginx /tmp/

# Install nginx.
RUN mkdir -p /etc/services.d/nginx /srv/www/html /var/log/nginx /var/cache/nginx /etc/nginx/conf.d && \
    mv /tmp/run_nginx /etc/services.d/nginx/run && \
    mv /tmp/nginx.conf /etc/nginx/nginx.conf && \
    mv /tmp/default.conf /etc/nginx/conf.d/default.conf && \
    mv /tmp/index.html /srv/www/html/index.html

EXPOSE 80 443

VOLUME ["/var/cache/nginx", "/var/log/nginx", "/srv/www/html"]

# Volumes
# - Conf: /etc/nginx/conf.d (default.conf)
# - Cache: /var/cache/nginx
# - Logs: /var/log/nginx
# - Data: /srv/www/html
