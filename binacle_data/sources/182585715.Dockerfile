FROM mapcentia/gc2core:ecw
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Install GDAL 2.2.1 from source
RUN wget http://download.osgeo.org/gdal/2.2.1/gdal221.zip && \
    unzip gdal221.zip &&\
    cd gdal-2.2.1 &&\
    ./configure \
    --with-python=yes \
    --with-ecw=/usr/local \
    --with-java=yes \
    --with-mdb=yes \
    --with-jvm-lib-add-rpath=yes


RUN cd gdal-2.2.1 &&\
    make

RUN cd gdal-2.2.1 &&\
    make install &&\
    ldconfig &&\
    ln -s /usr/local/bin/ogr2ogr /usr/bin/ogr2ogr