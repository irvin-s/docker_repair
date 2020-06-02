FROM devgeniem/alpine-php-base:latest
MAINTAINER Onni Hakala - Geniem Oy. <onni.hakala@geniem.com>

##
# Add Project files like nginx and php-fpm processes and configs
# Also custom scripts and bashrc
##
COPY system-root/ /

# Update path with composer files + wpcs
ENV PATH="$PATH:/data/code/vendor/.bin:/root/.composer/bin:/var/lib/wpcs/vendor/bin" \
    TERM="xterm" \
    DB_HOST="" \
    DB_NAME="" \
    DB_USER=""\
    DB_PASSWORD=""\
    # Set defaults which can be overriden
    DB_PORT="3306" \
    # Set defaults for redis
    WP_REDIS_PORT="6379" \
    WP_REDIS_DATABASE="0" \
    WP_REDIS_SCHEME="tcp" \
    WP_REDIS_CLIENT="pecl" \
    # Cronlock is used to stop simultaneous cronjobs in clusterised environments
    CRONLOCK_HOST="" \
    # This is for your project root
    PROJECT_ROOT="/data/code"\
    # This is used by nginx and php-fpm
    WEB_ROOT="/data/code/web"\
    # This is used automatically by wp-cli
    WP_CORE="/data/code/web/wp"\
    # This can be overidden by you, it's just default for us
    TZ="Europe/Helsinki"

# Set default path to project mountpoint
WORKDIR /data/code

EXPOSE 80

ENTRYPOINT ["/init"]
