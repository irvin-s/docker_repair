# Copyright (C) 2015 Stichting Akvo (Akvo Foundation)
#
# This file is part of Akvo Login.
#
# Akvo Login is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public licence as
# published by the Free Software Foundation, either version 3 of the
# licence.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public licence included below for more details.
#
# The full licence text is available at <http://www.gnu.org/licenses/agpl.html>.

FROM jboss/keycloak

MAINTAINER Stichting Akvo (Akvo Foundation)

# Environment setup
ENV AKVO_FILES_BASE_URL        http://files.support.akvo-ops.org/keycloak
ENV KEYCLOAK_DIR               /opt/jboss/keycloak
ENV KEYCLOAK_CONFIG_FILE       $KEYCLOAK_DIR/standalone/configuration/standalone.xml
ENV KEYCLOAK_THEME_FILE        $AKVO_FILES_BASE_URL/themes.tar.gz
ENV POSTGRESQL_DRIVER_DIR      $KEYCLOAK_DIR/modules/system/layers/base/org/postgresql/jdbc/main
ENV POSTGRESQL_DRIVER_VERSION  9.4-1206-jdbc42
ENV POSTGRESQL_DRIVER_URL      $AKVO_FILES_BASE_URL/postgresql-$POSTGRESQL_DRIVER_VERSION.jar
ENV POSTGRESQL_DB              keycloak
ENV POSTGRESQL_PORT            5432
ENV POSTGRESQL_USERNAME        keycloak
ENV POSTGRESQL_PASSWORD        password

# Install Akvo theme
RUN cd $KEYCLOAK_DIR
RUN curl -L $KEYCLOAK_THEME_FILE | tar xvz

# Install PostgreSQL JDBC driver
RUN mkdir -p $PSQL_DRIVER_DIR
RUN cd $PSQL_DRIVER_DIR
RUN curl -LO $POSTGRES_DRIVER_URL
ADD module.xml $PSQL_DRIVER_DIR

# Post-install configuration
ADD configure.xsl $KEYCLOAK_DIR
RUN saxon-xslt -o $KEYCLOAK_CONFIG_FILE $KEYCLOAK_CONFIG_FILE $KEYCLOAK_DIR/configure.xsl
