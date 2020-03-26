
FROM ${FROM_IMAGE}

# see http://label-schema.org/rc1/
LABEL org.label-schema.name="php" \
      org.label-schema.version="0.1" \
      org.label-schema.description="Core PHP image" \
      org.label-schema.vendor="Claranet GmbH" \
      org.label-schema.schema-version="1.1.18" \
      author1="Fabian Dörk <fabian.doerk@de.clara.net>" \
      author2="Tony Fahrion <tony.fahrion@de.clara.net>"


# GENERAL
ARG ERROR_EXIT_CODE=1
ARG ENABLE_CLEANUP=true
ENV WORKDIR=/app \
    BUILD_LOG=/app/logs/build.log \
    ENABLE_PATCHES="true"

# GCP
ARG ENABLE_GCP
ENV ENABLE_GCP="${ENABLE_GCP:-0}" \
    GOOGLE_ASSET_BUCKET_ENABLED="false" \
    ASSET_BUCKET_NAME="to-be-defined" \
    ASSET_VERSION="${ASSET_VERSION:-e.g.-commit-sha1}"

# OS
# libtcmalloc: to increase php-fpm and nginx performance
# busybox-static: provides crond, the normal package does not!
# ssmtp: synchronouse mailer, very handy in CLI scripts on docker
ENV PATH="${PATH}:${WORKDIR}/docker/bin" \
    BUILD_PACKAGES="ccache build-essential unzip" \
    SYSTEM_PACKAGES="ssmtp busybox-static netcat vim less tree libtcmalloc-minimal4 git postgresql-client gettext nginx" \
    JESSIE_PACKAGE_MAP="libpng16-16:libpng12-0 libicu57:libicu52 libmagickwand-6.q16-3:libmagickwand-6.q16-2 libmagickcore-6.q16-3:libmagickcore-6.q16-2 npm:" \
    ENABLE_NEWRELIC="false"

# NGINX
ENV NGINX_SITES_AVAILABLE="/etc/nginx/sites-available" \
    NGINX_SITES_ENABLED="/etc/nginx/sites-enabled" \
    DISABLE_NGINX_DAEMON="false" \
    PHPFPM_HOST="127.0.0.1" \
    PHPFPM_PORT="9000" \
    DOCUMENT_ROOT="${WORKDIR}/public" \
    COMPRESS_FILE_MATCH="^.*\.(css|js|xml|csv|txt|md|html)\$" \
    COMPRESS_FILE_PATHS="public"

# NODEJS
ENV ENABLE_NODEJS="true" \
    NODEJS_VERSION="8" \
    ENABLE_BOWER="true" \
    NPM="npm" \
    NPM_BUILD_PACKAGES="" \
    NPM_ARGS=""

# PHP
ENV PHP="php" \
    FPM="php-fpm" \
    NEWRELIC_PHP_VERSION="php5-8.0.0.204" \
    PHP_EXTENSIONS_STARTUP_ONLY="xdebug APCu imagick redis" \
    PHP_EXTENSIONS_STARTUP_ENABLE="" \
    PHP_EXTENSIONS="bcmath bz2 gd gmp intl json mbstring opcache dom curl pgsql pdo_pgsql pdo_mysql ldap soap zip xdebug-2.6.1 imagick-3.4.3 redis-3.1.6 APCu" \
    PHP_BUILD_PACKAGES="re2c libmagickwand-6.q16-dev libbz2-dev libldap2-dev libgmp-dev libicu-dev libpq-dev libpq-dev libreadline6-dev libedit-dev libxml2-dev libcurl4-openssl-dev zlib1g-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev" \
    SYSTEM_PACKAGES="${SYSTEM_PACKAGES} libldap-2.4-2 libpng16-16 libicu57 libjpeg62-turbo libfreetype6 libmagickwand-6.q16-3 libmagickcore-6.q16-3" \
    PHP_INI_DIR="/usr/local/etc/php" \
    PHP_INI_ALLOW_URL_FOPEN="Off" \
    PHP_INI_DATE_TIMEZONE="UTC" \
    PHP_INI_INCLUDE_PATH=".:${WORKDIR}:/usr/local/lib/php" \
    PHP_INI_MAX_EXECUTION_TIME="600" \
    PHP_INI_MAX_INPUT_TIME="60" \
    PHP_INI_MAX_INPUT_VARS="1000" \
    PHP_INI_MEMORY_LIMIT="256M" \
    PHP_INI_ERROR_LOG="php://stderr" \
    PHP_INI_POST_MAX_SIZE="256M" \
    PHP_INI_APC_ENABLED="0" \
    PHP_INI_APC_SHM_SIZE="50M" \
    PHP_INI_OPCACHE_ENABLE="0" \
    PHP_INI_OPCACHE_ENABLE_CLI="0" \
    PHP_INI_OPCACHE_MEMORY_CONSUMPTION="1024M" \
    PHP_INI_OPCACHE_OPTIMIZATION_LEVEL="-1" \
    PHP_INI_OPCACHE_VALIDATE_TIMESTAMPS="1" \
    PHP_INI_FILE_UPLOADS="On" \
    PHP_INI_UPLOAD_MAX_FILESIZE="64M" \
    PHP_INI_MAX_FILE_UPLOADS="100" \
    PHP_INI_SHORT_OPEN_TAG="False" \
    PHP_INI_NEWRELIC_APPNAME="myapp" \
    PHP_INI_NEWRELIC_FRAMEWORK="symfony2" \
    PHP_INI_NEWRELIC_LICENSE="xxx" \
    BLACKFIRE_AGENT="blackfire:8707" \
    CONSOLE="exec_console" \
    CODECEPT="${WORKDIR}/vendor/bin/codecept" \
    CODECEPTION_ARGS="" \
    COMPOSER_VERSION="1.6.5" \
    COMPOSER_ARGS="--no-dev" \
    COMPOSER_DUMP_ARGS="--optimize --classmap-authoritative --no-dev --apcu"

# SMTP
# https://symfony.com/doc/current/reference/configuration/swiftmailer.html
ENV ENABLE_SMTP="false" \
    SMTP_ENCRYPTION="" \
    SMTP_AUTH_METHOD="plain" \
    SMTP_HOST="smtp" \
    SMTP_USERNAME="" \
    SMTP_PASSWORD="" \
    SMTP_PORT="25" \
    SMTP_TIMEOUT="10"


COPY docker/*.sh ${WORKDIR}/docker/
COPY docker/build.d/base ${WORKDIR}/docker/build.d/base
COPY docker/shared_steps ${WORKDIR}/docker/shared_steps
RUN mkdir -p ${WORKDIR}/logs /run/php; \
    ln -s ${WORKDIR}/docker/entrypoint.sh /entrypoint.sh

ARG RUN_BUILD_BASE="true"
RUN if [ "${RUN_BUILD_BASE}" = "true" ]; then /entrypoint.sh build base || exit ${ERROR_EXIT_CODE}; fi

COPY . ${WORKDIR}/
COPY docker/etc /etc
COPY docker/usr /usr
COPY docker ${WORKDIR}/docker

# Clear ENV
# This makes it easier to reuse e.g. the install_system_packages.sh step in `deps`
# and provide an easy way to our customers to install additional system packages
ENV SYSTEM_PACKAGES="" \
    PHP_EXTENSIONS=""

# 80 => nginx
# 9000 => php-fpm
EXPOSE 80 9000

WORKDIR ${WORKDIR}
ENTRYPOINT [ "/entrypoint.sh" ]
CMD  [ "help" ]

# provide some onbuild generic things
ONBUILD ARG GITLAB_SERVER_NAME
ONBUILD ARG GITLAB_USER=gitlab-ci-token
ONBUILD ARG GITLAB_TOKEN
ONBUILD ARG ENABLE_CLEANUP=true
