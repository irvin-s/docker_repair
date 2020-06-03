FROM frodenas/ubuntu
MAINTAINER Dr Nic Williams

ENV PG_VERSION=9.5 \
    POSTGIS_VERSION=2.2 \
    JQ_VERSION=1.5 \
    DUMB_INIT_VERSION=1.1.1

RUN DEBIAN_FRONTEND=noninteractive \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main ${PG_VERSION}" > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update -y \
    && apt-get install -y python python-dev python-pip lzop pv \
    daemontools libpq-dev \
    postgresql-${PG_VERSION} \
    postgresql-${PG_VERSION}-postgis-${POSTGIS_VERSION} \
    postgresql-${PG_VERSION}-pgrouting \
    && service postgresql stop \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install pip --upgrade \
      && pip install wal-e==0.9.2 awscli --upgrade

RUN wget -O /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 \
      && chmod +x /usr/local/bin/jq \
      && jq --version

RUN wget -O /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_amd64 \
      && chmod +x /usr/local/bin/dumb-init

ENV PATH /usr/lib/postgresql/${PG_VERSION}/bin:$PATH
