FROM debian:stable
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get -y update --fix-missing
RUN apt-get -y install postgresql-client

RUN apt-get -y install build-essential git libfuse-dev libcurl4-openssl-dev libxml2-dev mime-support automake libtool pkg-config libssl-dev fuse

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse &&\
    cd s3fs-fuse/ &&\
    ./autogen.sh &&\
    ./configure --prefix=/usr --with-openssl &&\
    make &&\
    make install



COPY postgresqlbackup.sh /postgresqlbackup.sh
RUN chmod +x /postgresqlbackup.sh
ENTRYPOINT ["/postgresqlbackup.sh"]