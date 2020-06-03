FROM mapcentia/gc2core:base
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Install ECW 5.3.0
RUN wget https://s3-eu-west-1.amazonaws.com/mapcentia-tmp/ERDAS-ECW_JPEG_2000_SDK-5.3.0.zip &&\
    unzip ERDAS-ECW_JPEG_2000_SDK-5.3.0.zip &&\
    mkdir /usr/local/hexagon &&\
    cp -r ERDAS-ECW_JPEG_2000_SDK-5.3.0/Desktop_Read-Only/* /usr/local/hexagon &&\
    ln -s /usr/local/hexagon/lib/x64/release/libNCSEcw.so /usr/local/lib/libNCSEcw.so &&\
    ln -s /usr/local/hexagon/lib/x64/release/libNCSEcw.so.5.3.0 /usr/local/lib/libNCSEcw.so.5.3.0 &&\
    ldconfig

# Install GDAL 2.2.1 from source
RUN wget http://download.osgeo.org/gdal/2.2.1/gdal221.zip &&\
    unzip gdal221.zip

RUN cd gdal-2.2.1 &&\
    ./configure --with-python=yes --with-ecw=/usr/local/hexagon --without-libkml CXXFLAGS='-D_GLIBCXX_USE_CXX11_ABI=0'

RUN cd gdal-2.2.1 &&\
    make

RUN cd gdal-2.2.1 &&\
    make install &&\
    ldconfig &&\
    ln -s /usr/local/bin/ogr2ogr /usr/bin/ogr2ogr