#++++++++++++++++++++++++++++++++++++++
# PHP application Docker container
#++++++++++++++++++++++++++++++++++++++

FROM webdevops/php-nginx:7.2

ENV PROVISION_CONTEXT "development"
ENV WEB_DOCUMENT_ROOT "/app/.Build"
ENV WEB_NO_CACHE_PATTERN="\.(css|js|gif|png|jpg|svg|json|xml)$"

# Must explicitly turned on in dev env (default off)
RUN mkdir -p /opt/tmp/Development/ \
    && chown -R application:application /opt/tmp

# Deploy scripts/configurations
COPY etc/ /opt/docker/etc/

RUN ln -sf /opt/docker/etc/php/development.ini /opt/docker/etc/php/php.ini

RUN docker-image-cleanup

WORKDIR /app/
