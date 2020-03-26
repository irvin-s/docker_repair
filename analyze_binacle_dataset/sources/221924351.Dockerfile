FROM ubuntu:14.04

ENV LC_ALL C
ENV PG_VERSION 9.6
ENV KEYCLOAK_VERSION 3.4.3.Final
ENV KONG_VERSION 0.10.1
ENV MKT_VERSION_TAG acc
ENV PUB_VERSION_TAG acc

USER root

WORKDIR /tmp

ADD db-creation.sql /tmp
ADD t1g-inserts.sql /tmp
ADD t1g-schema.sql /tmp
ADD postgres.zip /tmp
ADD standalone.xml /tmp
ADD kong.conf /tmp
ADD start.sh /tmp
ADD application.conf /tmp
ADD wildfly_install.sh /tmp
ADD t1g-ear.ear /tmp
ADD kc-db-export.json /tmp
ADD wildfly-kc-import-service.sh /tmp
ADD wildfly-kc-no-import-service.sh /tmp
ADD key-auth-handler.lua /tmp
ADD fixtures.lua /tmp
ADD bower-mkt.json /tmp
ADD bower-pub.json /tmp
ADD config-mkt.yml /tmp
ADD config-pub.yml /tmp
ADD keycloak.json /tmp

RUN apt-get -y update
RUN apt-get -y upgrade
RUN ln -fs /usr/share/zoneinfo/Europe/Brussels /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
RUN apt-get install -y build-essential software-properties-common nano curl git unzip wget sudo netcat openssl libpcre3 dnsmasq procps perl
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee -a /etc/apt/sources.list.d/pgdg.list
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN apt-get install -y -q --no-install-recommends nodejs oracle-java8-installer postgresql-$PG_VERSION postgresql-client-$PG_VERSION postgresql-contrib-$PG_VERSION
RUN npm install pm2 -g

# Configure PostgreSQL
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf
RUN echo "host all  all    ::0/0  md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf

USER postgres

RUN /etc/init.d/postgresql start && \
    psql -f db-creation.sql && \
    psql t1gengine -f t1g-schema.sql && \
    psql t1gengine -f t1g-inserts.sql

USER root

# Install Wildfly & Keycloak overlay
RUN chmod u+x /tmp/wildfly_install.sh && /tmp/wildfly_install.sh && service wildfly stop && rm -rf /var/run/wildfly
RUN wget https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-overlay-$KEYCLOAK_VERSION.zip && \
    mv /tmp/keycloak-overlay-$KEYCLOAK_VERSION.zip /opt && \
    unzip -o /opt/keycloak-overlay-$KEYCLOAK_VERSION.zip -d /opt/wildfly
RUN /opt/wildfly/bin/jboss-cli.sh --file=/opt/wildfly/bin/keycloak-install.cli
RUN mv /tmp/postgres.zip /opt/wildfly/modules/system/layers/base/org && \
    unzip /opt/wildfly/modules/system/layers/base/org/postgres.zip -d /opt/wildfly/modules/system/layers/base/org && \
    rm /opt/wildfly/modules/system/layers/base/org/postgres.zip && \
    mv /tmp/standalone.xml /opt/wildfly/standalone/configuration/standalone.xml && \
    /etc/init.d/postgresql start && \
    mv /tmp/wildfly-kc-import-service.sh /etc/init.d/wildfly && \
    service wildfly start && \
    service wildfly stop && \
    rm -rf /var/run/wildfly && \
    mv /tmp/wildfly-kc-no-import-service.sh /etc/init.d/wildfly

RUN mv /tmp/application.conf /opt/wildfly/standalone/configuration && \
    mv /tmp/t1g-ear.ear /opt/wildfly/standalone/deployments

RUN /etc/init.d/postgresql start && \
    wget https://github.com/Kong/kong/releases/download/$KONG_VERSION/kong-$KONG_VERSION.trusty_all.deb && \
    sudo dpkg -i kong-$KONG_VERSION.trusty_all.deb && \
    mv /tmp/kong.conf /etc/kong/kong.conf && \
    # Install custom plugins
    luarocks install kong-plugin-jwt-up && \
    # HAL & JSON Threat protection plugins must be updated to replace Stringy dependency
    #    luarocks install kong-plugin-hal && \
    #    luarocks install kong-plugin-json-threat-protection && \
    mv /tmp/fixtures.lua /usr/local/share/lua/5.1/kong/plugins/jwt-up && \
    mv /tmp/key-auth-handler.lua /usr/local/share/lua/5.1/kong/plugins/key-auth/handler.lua && \
    kong start --vv

# Install Marketplace + overwrite bower.json to correct Keycloak version

RUN wget https://github.com/Trust1Team/api-market/archive/$MKT_VERSION_TAG.zip && \
    unzip /tmp/$MKT_VERSION_TAG.zip -d /opt/ && \
    mv /opt/api-market-$MKT_VERSION_TAG /opt/api-market && \
    mv /tmp/bower-mkt.json /opt/api-market/bower.json && \
    cp /tmp/keycloak.json /opt/api-market/config && \
    mv /tmp/config-mkt.yml /opt/api-market/config/config.yml && \
    rm -rf /tmp/$MKT_VERSION_TAG.zip && \
    cd /opt/api-market && \
    npm run deploy

# Install Publisher  + overwrite bower.json to correct Keycloak version

RUN wget https://github.com/Trust1Team/api-publisher/archive/$PUB_VERSION_TAG.zip && \
    unzip /tmp/$PUB_VERSION_TAG.zip -d /opt/ && \
    mv /opt/api-publisher-$PUB_VERSION_TAG /opt/api-publisher && \
    mv /tmp/bower-pub.json /opt/api-publisher/bower.json && \
    cp /tmp/keycloak.json /opt/api-publisher/config && \
    mv /tmp/config-pub.yml /opt/api-publisher/config/config.yml && \
    rm -rf /tmp/$PUB_VERSION_TAG.zip && \
    cd /opt/api-publisher && \
    npm run deploy

#Cleanup

RUN rm -rf /opt/keycloak-overlay-$KEYCLOAK_VERSION.zip && \
    rm -rf /tmp/hsperf* && \
    rm -rf /tmp/kong-$KONG_VERSION.trusty_all.deb && \
    rm -rf /tmp/npm* && \
    rm -rf /tmp/phantomjs && \
    rm -rf /tmp/*.sql && \
    rm -rf /tmp/wildfly* && \
    rm -rf /tmp/v8-* && \
    rm -rf /opt/wildfly/bin/kc-db-export.json

RUN ["chmod", "+x", "/tmp/start.sh"]

EXPOSE 5432 28080 28443 29990 29993 3000 3003 8000 8001

CMD /tmp/start.sh