
FROM claranet/php:1.1.14-php7.2.11

LABEL org.label-schema.name="claranet/spryker-demoshop" \
      org.label-schema.version="2.32.3" \
      org.label-schema.description="Dockerized Spyker Demoshop" \
      org.label-schema.vendor="Claranet GmbH" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vcs-url="https://github.com/claranet/spryker-demoshop" \
      author1="Fabian Dörk <fabian.doerk@de.clara.net>" \
      author2="Tony Fahrion <tony.fahrion@de.clara.net>"

# Override claranet/php image settings
ENV NPM_ARGS="--with-dev" \
    PHP_EXTENSIONS="redis" \
    SYSTEM_PACKAGES="graphviz redis-tools" \
    PHP_EXTENSIONS_STARTUP_ONLY="xdebug" \
    NODEJS_VERSION="10" \
    CODECEPTION_ARGS="-x CheckoutAvailabilityCest -x CmsGuiCreatePageCest -x NavigationCRUDCest -x NavigationTreeCest -x ProductRelationCreateRelationCest -x Smoke" \
    COMPOSER_ARGS="" \
    PHP_INI_OPCACHE_ENABLE="0"


# STATIC_FILES_YVES:
#   be aware, this list will be used to sync those files on a public object store
#   each reference should be relative to the repos path
#   php files will be omitted
#   result is e.g.: https://storage.googleapis.com/my-uniq-bucket-name/maintenance/index.html
#   ASSET_ENV = prod|dev or empty
ENV STATIC_FILES_YVES="path/within/repo path2/within/repo" \
    ASSET_ENV="" \
    ENABLE_DEMO_DATA="true" \
    CLOUDSDK_KEY_FILE="/mnt/gcloudServiceAccount/key.json" \
    ASSET_BUCKET_NAME="to-be-defined-on-gcp" \
    ENABLE_GOOGLE_ASSET_BUCKET="false"


# spryker
# disabled env vars: (so users are foced to set them in docker-compose/k8)
#    REDIS_STORAGE_PASSWORD="" \
#    REDIS_SESSION_PASSWORD="" \
#    ZED_DB_PASSWORD="" \
#    RABBITMQ_PASSWORD="" \
ENV APPLICATION_ENV="development" \
    STORES="DE AT US" \
    DEFAULT_STORE="DE" \
    DEFAULT_ZED_API_HOST="zed-nginx" \
    INIT_COLLECTOR_CHUNK_SIZE="2000"

# database
ENV ENABLE_PROPEL_DIFF="true" \
    ZED_DATABASE_HOST="database" \
    ZED_DATABASE_PORT="5432" \
    ZED_DATABASE_USERNAME="spryker" \
    ZED_DATABASE_DATABASE="spryker"

# rabbitmq
ENV RABBITMQ_HOST="rabbitmq" \
    RABBITMQ_PORT="5672" \
    RABBITMQ_USERNAME="spryker" \
    RABBITMQ_VIRTUAL_HOST="spryker"

# jenkins
ENV JENKINS_HOST="jenkins" \
    JENKINS_WORKDIR="/home/jenkins/agent" \
    JENKINS_HOME="/home/jenkins" \
    JENKINS_JRE_PACKAGE="openjdk-8-jre" \
    destination_release_dir="${WORKDIR}"

# redis
ENV STORAGE_REDIS_HOST="storage-redis" \
    STORAGE_REDIS_PORT="6379" \
    YVES_SESSION_REDIS_HOST="yves-session-redis" \
    YVES_SESSION_REDIS_PORT="6379" \
    ZED_SESSION_REDIS_HOST="zed-session-redis" \
    ZED_SESSION_REDIS_PORT="6379" \
    REDIS_STORE_DB_FACTOR="3"

# elasticsearch
ENV ELASTICSEARCH_HOST="elasticsearch" \
    ELASTICSEARCH_PROTOCOL="http" \
    ELASTICSEARCH_PORT="9200" \
    ES_INDEX_NUMBER_OF_SHARDS="1" \
    ES_INDEX_NUMBER_OF_REPLICAS="0"

COPY docker/etc /etc/
COPY . ${WORKDIR}/

RUN /entrypoint.sh build deps

# Only build jenkins on demand
ARG ENABLE_JENKINS_BUILD=false
RUN if [ "${ENABLE_JENKINS_BUILD}" = "true" ]; then /entrypoint.sh build jenkins; fi
