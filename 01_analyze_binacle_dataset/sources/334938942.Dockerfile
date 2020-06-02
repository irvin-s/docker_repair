FROM appsvcorg/nginx-fpm:0.2-test
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>

# ========
# ENV vars
# ========
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
# wordpress 
ENV DRUPAL_SOURCE "/usr/src/drupal" 
ENV DRUPAL_HOME "/home/site/wwwroot" 

# ====================
# Download and Install
# ~. essentials
# 1. Drupal
# ====================

RUN mkdir -p $DOCKER_BUILD_HOME
WORKDIR $DOCKER_BUILD_HOME

# -------------
# 1. Drupal
# -------------
RUN  mkdir -p $DRUPAL_SOURCE 
COPY drupal.tar.gz $DRUPAL_SOURCE/
    
# =====
# final
# =====
WORKDIR $DRUPAL_HOME
RUN rm -rf $DOCKER_BUILD_HOME
# php
COPY php.ini /etc/php/7.0/cli/php.ini
# nginx
COPY nginx.conf /etc/nginx/nginx.conf

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
