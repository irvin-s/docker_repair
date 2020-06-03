# dockerfile for postgres10 server
FROM ubuntu:18.04

# Set environment (set proper unicode locale, hush debconfig, etc.
# Set PATH so that subsequent pip3 commands install into virtualenv.
# activate command does not work within Docker for some reason
ENV DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    PATH=/usr/lib/postgresql/10/bin:$PATH \
    GOSU_VERSION=1.10

#
# - Set default shell to bash,
# - Update package lists
# - Install APT depdendencies
#
RUN set -x && \
    unlink /bin/sh; ln -s bash /bin/sh && \
    apt-get -q update --fix-missing && \
    apt-get -q install -y --no-install-recommends locales wget ca-certificates unzip build-essential gnupg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#
# Set default locale
#
RUN update-locale LC_ALL=C.UTF-8 LANG=C.UTF-8

# Add PostgreSQL user and group
RUN set -x && groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

# Install Postgres 10, but don't create a cluster
RUN set -x && \
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
    wget -q -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get -q update --fix-missing && \
    apt-get -q install -y --no-install-recommends postgresql-common pgtop postgresql-server-dev-10 && \
    sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
    apt-get -q install -y --no-install-recommends postgresql-10 postgresql-contrib-10 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install gosu
RUN set -x && \
    wget -q -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# Create /var/run/postgresql folder
RUN set -x && mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

# Copy config to the data directory
COPY docker/postgres/*.conf /etc/db_config/

# Copy entrypoint
COPY docker/postgres/entrypoint.sh /

# Make sure permissions are set properly on entrypoint
RUN set -x && chmod a+x /entrypoint.sh

# Expose port
EXPOSE 5432

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Set default command (argument to entrypoint.sh)
CMD ["postgres"]