FROM amazonlinux:2-with-sources
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# PostgreSQL and command line tools
RUN amazon-linux-extras install \
    postgresql9.6 \
    nano \
    vim \
  && yum install -y \
    awscli \
    curl \
    git \
    groff \
    lynx \
    postgresql \
    postgresql-contrib \
    postgresql-devel \
    postgresql-docs \
    postgresql-server \
    procps-ng \
    shadow-utils \
    tar \
    wget \
  && yum clean all \
  && rm -rf /var/cache/yum

# PostGIS build dependencies
RUN yum update -y \
  && yum install -y \
    boost-devel \
    bzip2 \
    file \
    gcc \
    gcc-c++ \
    gettext-devel \
    gmp-devel \
    json-c-devel \
    libxml2-devel \
    make \
    mpfr-devel \
    unzip \
  && yum clean all \
  && rm -rf /var/cache/yum

# setup for builds
ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf \
  && mkdir -p /usr/local/src/
WORKDIR /usr/local/src/

# source installs
ENV CMAKE_MAJOR 3.10
ENV CMAKE_VERSION ${CMAKE_MAJOR}.2
RUN wget -q https://cmake.org/files/v${CMAKE_MAJOR}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh \
  && chmod +x cmake-${CMAKE_VERSION}-Linux-x86_64.sh \
  && ./cmake-${CMAKE_VERSION}-Linux-x86_64.sh --prefix=/usr/local --exclude-subdir --skip-license

ENV CGAL_VERSION 4.11.1
RUN wget -q https://github.com/CGAL/cgal/archive/releases/CGAL-${CGAL_VERSION}.tar.gz \
  && tar xf CGAL-${CGAL_VERSION}.tar.gz \
  && cd cgal-releases-CGAL-${CGAL_VERSION} \
  && cmake . > ../cgal.cmake \
  && make \
  && make install \
  && ldconfig

ENV PROTOBUF_VERSION 3.5.1
RUN wget -q https://github.com/google/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-cpp-${PROTOBUF_VERSION}.tar.gz \
  && tar xf protobuf-cpp-${PROTOBUF_VERSION}.tar.gz \
  && cd /usr/local/src/protobuf-${PROTOBUF_VERSION} \
  && ./configure > ../protobuf.configure \
  && make > /dev/null \
  && make install > /dev/null \
  && ldconfig

ENV PROTOBUF_C_VERSION 1.3.0
RUN wget -q https://github.com/protobuf-c/protobuf-c/releases/download/v${PROTOBUF_C_VERSION}/protobuf-c-${PROTOBUF_C_VERSION}.tar.gz \
  && tar xf protobuf-c-${PROTOBUF_C_VERSION}.tar.gz \
  && cd /usr/local/src/protobuf-c-${PROTOBUF_C_VERSION} \
  && ./configure > ../protobuf-c.configure \
  && make > /dev/null \
  && make install > /dev/null \
  && ldconfig

ENV GEOS_VERSION 3.6.2
RUN wget -q http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2 \
  && tar xf geos-${GEOS_VERSION}.tar.bz2 \
  && cd /usr/local/src/geos-${GEOS_VERSION} \
  && ./configure > ../geos.configure \
  && make > /dev/null \
  && make install > /dev/null \
  && ldconfig

ENV PROJ_VERSION 4.9.3
ENV DATUMGRID_VERSION 1.6
RUN wget -q http://download.osgeo.org/proj/proj-${PROJ_VERSION}.tar.gz \
  && tar xf proj-${PROJ_VERSION}.tar.gz \
  && wget -q http://download.osgeo.org/proj/proj-datumgrid-${DATUMGRID_VERSION}.zip \
  && cd /usr/local/src/proj-${PROJ_VERSION} \
  && ./configure > ../proj.configure \
  && make > /dev/null \
  && make install > /dev/null \
  && ldconfig \
  && cd /usr/local/share/proj/ \
  && unzip /usr/local/src/proj-datumgrid-${DATUMGRID_VERSION}.zip

ENV GDAL_VERSION 2.2.4
RUN wget -q http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz \
  && tar xf gdal-${GDAL_VERSION}.tar.gz \
  && cd /usr/local/src/gdal-${GDAL_VERSION} \
  && ./configure > ../gdal.configure \
  && make -j 4 > /dev/null \
  && make install > /dev/null \
  && ldconfig

ENV POSTGIS_VERSION 2.4.3
RUN wget -q https://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz \
  && tar xf postgis-${POSTGIS_VERSION}.tar.gz \
  && cd /usr/local/src/postgis-${POSTGIS_VERSION} \
  && ./configure > ../postgis.configure \
  && make > /dev/null \
  && make install > /dev/null \
  && ldconfig

# pgRouting
ENV PGROUTING_VERSION 2.5.2
RUN yum install -y perl-Data-Dumper
RUN curl -Ls https://github.com/pgRouting/pgrouting/archive/v${PGROUTING_VERSION}.tar.gz \
  > pgrouting-${PGROUTING_VERSION}.tar.gz \
  && tar xf pgrouting-${PGROUTING_VERSION}.tar.gz \
  && cd pgrouting-${PGROUTING_VERSION} \
  && mkdir build \
  && cd build \
  && cmake .. > ../../pgrouting.cmake \
  && make > ../../pgrouting.make \
  && make install > /dev/null \
  && ldconfig

# make the users
RUN useradd --shell /bin/bash --user-group --create-home dbsuper \
  && mkdir -p /home/dbsuper/Projects/ \
  && echo "alias l='ls -ACF --color=auto'" >> /etc/bashrc \
  && echo "alias ll='ls -ltrAF --color=auto'" >> /etc/bashrc
COPY home-scripts /home/dbsuper/
COPY amazon-scripts/1make-dbusers.bash /var/lib/pgsql/
RUN chmod +x /home/dbsuper/*.bash /var/lib/pgsql/1make-dbusers.bash
RUN chown postgres:postgres /var/lib/pgsql/1make-dbusers.bash

USER postgres
ARG DB_USERS_TO_CREATE
RUN initdb --locale=en_US.utf8 --encoding=UTF8 -D /var/lib/pgsql/data/main \
  && pg_ctl start -w -D /var/lib/pgsql/data/main \
  && createuser --superuser dbsuper \
  && createdb --owner=dbsuper dbsuper \
  && bash /var/lib/pgsql/1make-dbusers.bash \
  && pg_ctl stop -w -D /var/lib/pgsql/data/main

# do backups at the end so rest of image doesn't need a rebuild
USER root
COPY Backups /home/dbsuper/Backups
COPY Raw /home/dbsuper/Raw
RUN chown -R dbsuper:dbsuper /home/dbsuper

USER postgres
CMD pg_ctl -D /var/lib/pgsql/data/main start; /usr/bin/sleep 1001d
