FROM postgres:9.6
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"

# Repo for up-to-date R
COPY cran.list.stretch /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'

# Backports
COPY backports.list.stretch /etc/apt/sources.list.d/backports.list

# Install apt packages
RUN apt-get update \
  && apt-get install -qqy --no-install-recommends \
    postgis \
    postgresql-9.6-postgis-2.4 \
    postgresql-9.6-postgis-2.4-scripts \
    postgresql-9.6-postgis-scripts \
    postgresql-9.6-pgrouting \
    postgresql-9.6-mysql-fdw \
    postgresql-9.6-ogr-fdw \
    postgresql-9.6-python3-multicorn \
    awscli \
    bash-completion \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    command-not-found \
    curl \
    emacs-nox \
    expat \
    gdal-bin \
    geotiff-bin \
    gsl-bin \
    git \
    less \
    libboost-dev \
    libboost-program-options-dev \
    libcairo2-dev \
    libexpat1-dev \
    libgdal-dev \
    libgeotiff-dev \
    libgsl-dev \
    libjq-dev \
    libpq-dev \
    libpqxx-dev \
    libprotobuf-dev \
    libspatialite-dev \
    libssh2-1-dev \
    libssl-dev \
    libudunits2-dev \
    libv8-3.14-dev \
    lynx \
    mdbtools \
    mdbtools-dev \
    nano \
    openssh-client \
    p7zip \
    postgresql-client-9.6 \
    proj-bin \
    protobuf-compiler \
    python-dev \
    python3-dev \
    python3-csvkit \
    r-base-dev \
    spatialite-bin \
    tar \
    time \
    udunits-bin \
    unixodbc-dev \
    unar \
    unrar-free \
    unzip \
    vim-nox \
    virtualenvwrapper \
    wget \
  && apt-get clean \
  && apt-file update \
  && update-command-not-found

    #librasterlite-dev \
    #rasterlite-bin \

# copy the root scripts to /usr/local/src
RUN mkdir -p /usr/local/src
COPY postgis-root-scripts  /usr/local/src/
RUN chmod +x /usr/local/src/*.bash

# database superusers
RUN useradd --shell /bin/bash --user-group --create-home dbsuper \
  && mkdir -p /home/dbsuper/Projects
COPY home-scripts /home/dbsuper/
ARG DB_USERS_TO_CREATE
RUN bash /usr/local/src/make-dbusers-linux.bash \
  && mkdir -p /gisdata \
  && echo "alias l='ls -ACF --color=auto'" >> /etc/bash.bashrc \
  && echo "alias ll='ls -ltrAF --color=auto'" >> /etc/bash.bashrc

# set up automatic restores and dbsuper home
COPY postgis-scripts/1make-dbsuper.sh Backups/restore-all.sh /docker-entrypoint-initdb.d/
RUN chmod +x /home/dbsuper/*.bash \
  && chmod +x /docker-entrypoint-initdb.d/*.sh \
  && chown -R postgres:postgres /gisdata
COPY postgis-scripts/Rprofile.site /home/dbsuper/.Rprofile
COPY Backups /home/dbsuper/Backups
COPY Raw /home/dbsuper/Raw
RUN chown -R dbsuper:dbsuper /home/dbsuper
