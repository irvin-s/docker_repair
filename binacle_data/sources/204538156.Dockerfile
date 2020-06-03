# Docker - nginx
#
# Use official nginx as base image for build
FROM nginx:latest

# VERSION 0.0.1
MAINTAINER William Hale <salt@snowdrift.coop>

# Let Docker handle logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

# Enable CiviCRM
COPY civicrm.conf /etc/nginx/conf.d/default.conf

# Cleanup
RUN apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

LABEL Description="Docker for Snowdrift.coop CRM. Debian Jessie+nginx+MariaDB+PHP5.6+Drupal7/Drush+CiviCRM" \
  Version="0.0.1"
