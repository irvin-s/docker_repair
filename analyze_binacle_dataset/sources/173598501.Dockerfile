FROM dimaip/docker-neos-alpine:latest
ENV PHP_TIMEZONE=Europe/Moscow
ENV AWS_ENDPOINT=https://hb.bizmrg.com
ENV AWS_BACKUP_ARN=s3://psmb-neos-resources/db/sfi/
ENV REPOSITORY_URL=https://github.com/psmb/SfiDistr
ENV DONT_PUBLISH_PERSISTENT=1
WORKDIR /data/www-provisioned
RUN chown -R 80:80 /composer/ && \
    chown -R 80:80 /data/www-provisioned && \
    /bin/bash -c "source /init-php-conf.sh"
USER 80
COPY --chown=80:80 composer.json /data/www-provisioned/composer.json
RUN composer install && \
    rm -rf /composer/cache && \
    mkdir -p /data/www-provisioned/Configuration && \
    cp /Settings.yaml /data/www-provisioned/Configuration/
COPY --chown=80:80 ./ /data/www-provisioned/
RUN composer run-script post-update-cmd
USER root
# HEALTHCHECK --interval=30s --timeout=15s --start-period=30s --retries=3 CMD curl -f http://localhost/ | grep "This website is powered by Neos"
