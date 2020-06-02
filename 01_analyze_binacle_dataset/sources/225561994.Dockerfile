#vim: set ft=dockerfile
FROM postgres:%%PG_VER%%
MAINTAINER Julien Rouhaud <julien.rouhaud@dalibo.com>

WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y \
    gcc \
    jq \
    make \
    postgresql-contrib-%%PG_VER%% \
    postgresql-server-dev-%%PG_VER%% \
    wget \
    && wget -O- $(wget -O- https://api.github.com/repos/powa-team/powa-archivist/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/powa-team/pg_qualstats/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/powa-team/pg_stat_kcache/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/HypoPG/hypopg/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && wget -O- $(wget -O- https://api.github.com/repos/rjuju/pg_track_settings/releases/latest|jq -r '.tarball_url') | tar -xzf - \
    && for f in $(ls); do cd $f; make install; cd ..; rm -rf $f; done \
    && apt-get purge -y --auto-remove gcc jq make postgresql-server-dev-%%PG_VER%% wget \
    && rm -rf /var/lib/apt/lists/*

# configure powa-archivist
ADD setup_powa-archivist.sh /docker-entrypoint-initdb.d/
ADD install_all.sql /usr/local/src/
