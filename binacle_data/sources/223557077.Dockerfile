# VERSION 1.10.2
# AUTHOR: Maksim Pecherskiy
# DESCRIPTION: Airflow container for running City of San Diego Airflow Instances.  Original work by Puckel_
# BUILD: docker build --rm -t mrmaksimize/docker-airflow .
# SOURCE: https://github.com/mrmaksimize/docker-airflow

FROM python:3.6
LABEL maintainer="mrmaksimize"


# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Airflow
ARG AIRFLOW_VERSION=1.10.2
ARG AIRFLOW_HOME=/usr/local/airflow
ARG GDAL_VERSION=2.1.0

ENV AIRFLOW_GPL_UNIDECODE yes

# Define en_US.
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV LC_MESSAGES en_US.UTF-8

# GDAL ENV
ENV GDAL_DATA /usr/share/gdal/2.1
ENV GDAL_VERSION $GDAL_VERSION
ENV CPLUS_INCLUDE_PATH=/usr/include/gdal
ENV C_INCLUDE_PATH=/usr/include/gdal


# Oracle Essentials
ENV ORACLE_HOME /opt/oracle
ENV ARCH x86_64
ENV DYLD_LIBRARY_PATH /opt/oracle
ENV LD_LIBRARY_PATH /opt/oracle

#R
ENV R_BASE_VERSION 3.5.3



# Update apt and install
RUN apt-get update -yqq \
    && apt-get upgrade -yqq \
    && apt-get install -yqq --no-install-recommends \
        apt-utils \
        build-essential \
        curl \
        freetds-bin \
        freetds-dev \
        git \
        gnupg2 \
        less \
        locales \
        libaio1 \
        libcurl4-gnutls-dev \
        libgdal-dev \
        libgeos-dev \
        libhdf4-alt-dev \
        libhdf5-serial-dev \
        libnetcdf-dev \
        libpoppler-dev \
        libproj-dev \
        libpq-dev \
        libspatialindex-dev \
        libspatialite-dev \
        libxml2-dev \
        netcat \
        pandoc \
        python3-software-properties \
        python3-dev \
        python3-numpy \
        rsync \
        software-properties-common \
        smbclient \
        sqlite3 \
        unzip \
        vim \
        wget

# Update Locales, add Airflow User
RUN sed -i 's/^# en_US.UTF-8 UTF-8$/en_US.UTF-8 UTF-8/g' /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 \
    && useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow


# NodeJS packages
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g mapshaper \
    && npm install -g geobuf


RUN pip install -U pip setuptools wheel \
    && pip install apache-airflow[crypto,celery,postgres,slack,s3,jdbc,mysql,mssql,ssh,password,rabbitmq,samba]==${AIRFLOW_VERSION} \
    && pip install boto3 \
    && pip install bs4 \
    && pip install fiona \
    && pip install gdal==2.1.0 \
    && pip install git+https://github.com/jguthmiller/pygeobuf.git@geobuf-v3 \
    && pip install geojson \
    && pip install geopandas \
    && pip install geomet \
    && pip install lxml \
    && pip install keen \
    && pip install ndg-httpsclient \
    && pip install pandas \
    && pip install pymssql \
    && pip install psycopg2-binary \
    && pip install pyasn1 \
    && pip install PyGithub \
    && pip install pyOpenSSL \
    && pip install pytz \
    && pip install "redis~=3.2" \
    && pip install requests \
    && pip install rtree \
    && pip install shapely \
    && pip install "tornado>=4.2.0,<6.0.0" \
    && pip install xlrd \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /usr/share/man \
        /usr/share/doc \
        /usr/share/doc-base



# R Installs
## Use Debian unstable via pinning -- new style via APT::Default-Release
RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list \
    && echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default

## Now install R and littler, and create a link for littler in /usr/local/bin
RUN apt-get update \
    && apt-get install -t unstable -y --no-install-recommends \
      littler \
      r-cran-littler \
      r-base=${R_BASE_VERSION}-* \
      r-base-dev=${R_BASE_VERSION}-* \
      r-recommended=${R_BASE_VERSION}-* \
      && ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
      && ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
      && ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
      && ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
      && install.r docopt \
      && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
      #&& rm -rf /var/lib/apt/lists/*


RUN install.r dplyr \
    crosstalk \
    data.table \
    DT \
    dygraphs \
    flexdashboard \
    ggplot2 \
    leaflet \
    mgcv \
    plotly \
    rmarkdown \
    rsconnect \
    shiny \
    tidyr \
    viridis

RUN chown -R airflow /usr/local/lib/R/site-library* /usr/local/lib/R/site-library/*




# Get Oracle Client
# TODO -- ADD
ADD http://datasd-dev-assets.s3.amazonaws.com/oracle.zip ${AIRFLOW_HOME}/
ADD https://github.com/energyhub/secretly/releases/download/0.0.6/secretly-linux-amd64 /usr/local/bin/secretly

COPY script/entrypoint.sh ${AIRFLOW_HOME}/entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

RUN chmod +x /usr/local/bin/secretly


RUN unzip ${AIRFLOW_HOME}/oracle.zip -d /opt \
  && env ARCHFLAGS="-arch $ARCH" pip install cx_Oracle \
  && rm ${AIRFLOW_HOME}/oracle.zip

RUN chown -R airflow: ${AIRFLOW_HOME} \
    && chmod +x ${AIRFLOW_HOME}/entrypoint.sh \
    && chown -R airflow /usr/lib/python* /usr/local/lib/python* \
    && chown -R airflow /usr/local/bin* /usr/local/bin/*

EXPOSE 8080 5555 8793

USER airflow
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["secretly", "./entrypoint.sh"]
CMD ["secretly", "webserver"] # set default arg for entrypoint

