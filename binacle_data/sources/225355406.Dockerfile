FROM muccg/python-base:3.6-debian-8
MAINTAINER https://github.com/muccg/rdrf/

ENV PROJECT_NAME rdrf
ENV PROJECT_SOURCE https://github.com/muccg/rdrf.git
ENV DEPLOYMENT prod
ENV PRODUCTION 1
ENV DEBUG 0
ENV STATIC_ROOT /data/static
ENV WRITABLE_DIRECTORY /data/scratch
ENV MEDIA_ROOT /data/static/media
ENV LOG_DIRECTORY /data/log
ENV LOCALE_PATHS /data/translations/locale
ENV DJANGO_SETTINGS_MODULE rdrf.settings

RUN env | sort

# Project specific deps
RUN apt-get update && apt-get install -y --no-install-recommends \
  gettext \
  libpcre3 \
  libpq5 \
  mime-support \
  nodejs-legacy \
  unixodbc \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENTRYPOINT ["/bin/sh"]
