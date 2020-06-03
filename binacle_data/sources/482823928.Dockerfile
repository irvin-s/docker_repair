FROM ruby:2.5.1

RUN apt-get update
RUN apt-get install -y apt-transport-https sudo libssl-dev

# Install Postgresql
ENV PG_APP_HOME="/etc/docker-postgresql"\
    PG_VERSION=9.6 \
    PG_USER=postgres \
    PG_HOME=/var/lib/postgresql \
    PG_RUNDIR=/run/postgresql \
    PG_LOGDIR=/var/log/postgresql \
    PG_CERTDIR=/etc/postgresql/certs

ENV PG_BINDIR=/usr/lib/postgresql/${PG_VERSION}/bin \
    PG_DATADIR=${PG_HOME}/${PG_VERSION}/main

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
    && echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y acl \
        postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} \
    && ln -sf ${PG_DATADIR}/postgresql.conf /etc/postgresql/${PG_VERSION}/main/postgresql.conf \
    && ln -sf ${PG_DATADIR}/pg_hba.conf /etc/postgresql/${PG_VERSION}/main/pg_hba.conf \
    && ln -sf ${PG_DATADIR}/pg_ident.conf /etc/postgresql/${PG_VERSION}/main/pg_ident.conf \
    && rm -rf ${PG_HOME} \
    && rm -rf /var/lib/apt/lists/*

COPY postgresql/runtime/ ${PG_APP_HOME}/
COPY postgresql/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

RUN apt-get install -y git curl imagemagick # apt-utils

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -y install yarn

# Install database deps
RUN apt-get install -y libpq-dev # postgresql-contrib

# Install FarmBot Web App
WORKDIR /opt
#RUN git clone https://github.com/FarmBot/Farmbot-Web-App -b master --depth=10
RUN wget "https://github.com/FarmBot/Farmbot-Web-App/archive/v6.4.2.tar.gz" -O farmbot-web-app.tar.gz
RUN tar -xvf farmbot-web-app.tar.gz
RUN mv /opt/Farmbot-Web-App-* /opt/Farmbot-Web-App

WORKDIR /opt/Farmbot-Web-App
RUN gem install bundler
RUN npm install yarn 
RUN bundle install 
RUN yarn install

ADD database.yml config/database.yml    
ADD application.yml config/application.yml

RUN nohup /sbin/entrypoint.sh

ADD start.sh /start.sh
RUN chmod +x /start.sh

ENV HOSTIP="your_domain_or_ip" \
	PGHOST="localhost" \
	PGPORT="5432" \
	PGUSER=farmbot \
	PGPASS="farmbot1234" \
	PGDBNAME="farmbot" \
	WSPORT="15675"

EXPOSE 3000 3000
EXPOSE 3808 3808

CMD ["/bin/bash","-c","/start.sh"]
