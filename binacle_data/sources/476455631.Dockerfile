FROM ubuntu:12.04
MAINTAINER sabalah21@gmail.com

# Configuring locales
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-reconfigure locales && \
      locale-gen en_US.UTF-8 && \
      update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    python-software-properties

RUN add-apt-repository ppa:cartodb/postgresql-9.3 && \
    add-apt-repository ppa:cartodb/gis && \
    add-apt-repository ppa:cartodb/redis && \
    add-apt-repository ppa:cartodb/nodejs-010

RUN apt-get update && \
    apt-get install -y \
    autoconf \
    automake \
    build-essential \
    ca-certificates \
    checkinstall \
    git-core \
    git \
    libtool \
    libpq5 \
    libpq-dev \
    libxml2-dev \
    liblwgeom-2.1.8 \
    netcat \
    nodejs \
    python-setuptools \
    python2.7-dev \
    python-dev \
    pgtune \
    postgresql-client-9.3 \
    postgresql-client-common \
    postgresql-9.3 \
    postgresql-contrib-9.3 \
    postgresql-server-dev-9.3 \
    postgresql-plpython-9.3 \
    postgresql-9.3-plproxy \
    postgis \
    postgresql-9.3-postgis-2.2 \
    postgresql-9.3-postgis-scripts \
    unzip \
    vim \
    wget \
    zip

# GIS dependencies
RUN apt-get install -y proj proj-bin proj-data libproj-dev
RUN apt-get install -y libjson0 libjson0-dev python-simplejson
RUN apt-get install -y libgeos-c1v5 libgeos-dev
RUN apt-get install -y gdal-bin libgdal1-dev libgdal-dev
RUN apt-get install -y ogr2ogr2-static-bin

# Set gdal enviorment variables
ENV CPLUS_INCLUDE_PATH $CPLUS_INCLUDE_PATH:/usr/include/gdal
ENV C_INCLUDE_PATH $C_INCLUDE_PATH:/usr/include/gdal
ENV PATH $PATH:/usr/include/gdal

# Set connections policy
RUN rm /etc/postgresql/9.3/main/pg_hba.conf
ADD ./opt/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

ADD ./opt/auth-configuration.sh /opt/auth-configuration.sh
RUN chmod 0755 /opt/auth-configuration.sh
RUN service postgresql start && /opt/auth-configuration.sh && \
    service postgresql stop

# Setup template database
ADD ./opt/template-postgis.sh /opt/template-postgis.sh
RUN service postgresql start && \
    /bin/su postgres -c /opt/template-postgis.sh && \
    ldconfig && \
    service postgresql stop

# Install cartodb extension
RUN git clone https://github.com/CartoDB/cartodb-postgresql
RUN cd cartodb-postgresql && git checkout $(git describe --abbrev=0 --tags)
RUN cd cartodb-postgresql && PGUSER=postgres make all install

# Install schema_triggers
RUN git clone https://github.com/CartoDB/pg_schema_triggers.git
RUN cd pg_schema_triggers && make all install
RUN cd pg_schema_triggers && sed -i \
    "/#shared_preload/a shared_preload_libraries = 'schema_triggers.so'" \
    /etc/postgresql/9.3/main/postgresql.conf

# Run tests
RUN service postgresql start && \
    cd /cartodb-postgresql && \
    PGUSER=postgres make installcheck && \
    service postgresql stop

RUN service postgresql start && \
    createuser publicuser --no-createrole --no-createdb --no-superuser -U postgres && \
    createuser tileuser --no-createrole --no-createdb --no-superuser -U postgres && \
    service postgresql stop

# Copy all postgresql data becuase of volume initialization
RUN mkdir /tmp/postgres-backup 
RUN cp -r /var/lib/postgresql/* /tmp/postgres-backup/

CMD ["/bin/bash"]
