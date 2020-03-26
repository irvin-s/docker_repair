FROM debian:jessie
MAINTAINER Michal Cichra <michal.cichra@gmail.com>

ENV LANG="cs_CZ.UTF-8" PG_VERSION="9.4" PGDATA="/data"

VOLUME ["/data"]

RUN apt-get -y update \
 && apt-get -y install ca-certificates wget lsb-release locales \
 && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
 && echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
 && apt-get -y update \
 && apt-get install -y postgresql-$PG_VERSION postgresql-client-$PG_VERSION postgresql-contrib-$PG_VERSION \
		       supervisor \
 && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
 %% echo LANG=${LANG} > /etc/default/locale \
 && grep ${LANG} /usr/share/i18n/SUPPORTED > /etc/locale.gen \
 && locale-gen

# why these are commented?
# RUN apt-get install -y language-selector-common
# RUN apt-get install -y $(check-language-support --language=$LANG)

RUN mkdir -p ${PGDATA} && chown postgres:postgres ${PGDATA} \
 && rm -rf  /var/lib/postgresql/${PG_VERSION}/main \
 && ln -s ${PGDATA} /var/lib/postgresql/${PG_VERSION}/main

ADD postgres.sh /var/lib/postgresql/postgres.sh
RUN chmod +x /var/lib/postgresql/postgres.sh
ADD supervisord.conf /etc/supervisor/supervisord.conf

CMD ["supervisord"]

EXPOSE 5432
