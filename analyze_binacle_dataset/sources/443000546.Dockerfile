##
# ojo-bot base image stack using conda
# Target is Heroku using Docker [Everything has to be built in /app ]
#
# Pat Cappelaere Vightel
# pat@cappelaere.com
#
# GDAL (with-python), PROJ, GEOS
# Node.js 4.2.3
# 

# Inherit from Heroku's stack
FROM heroku/cedar:14

MAINTAINER Pat Cappelaere <pat@cappelaere.com>

# Install apt dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    curl wget git

RUN mkdir /app /app/user
WORKDIR /app/user

ENV MINICONDA	/app/user/miniconda

# Set up Miniconda environment for python2
ENV PATH ${MINICONDA}/bin:$PATH

RUN curl https://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh -s -o miniconda.sh && \
    bash miniconda.sh -p ${MINICONDA} -b

RUN conda update --yes conda && conda install pip --yes
RUN conda install \
  netcdf4 libnetcdf proj4 pyproj geos hdf4 hdf5 h5py lxml gdal libgdal \
  numpy scipy matplotlib ipython pillow
RUN pip install boto boto3 pytrmm python-dateutil

# Install potrace
RUN mkdir ${MINICONDA}/potrace && cd ${MINICONDA}/potrace && wget http://potrace.sourceforge.net/download/1.13/potrace-1.13.tar.gz && tar -zxf potrace-1.13.tar.gz
RUN cd ${MINICONDA}/potrace/potrace-1.13 && ./configure --prefix ${MINICONDA} && make && make install
RUN rm -rf ${MINICONDA}/potrace

# Install grib_api
RUN mkdir ${MINICONDA}/grib && cd ${MINICONDA}/grib && wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.14.4-Source.tar.gz && tar -xzvf grib_api-1.14.4-Source.tar.gz
RUN cd ${MINICONDA}/grib/grib_api-1.14.4-Source && ./configure --prefix ${MINICONDA} && make && make install
RUN rm -rf ${MINICONDA}/grib

ENV GRIBAPI_DIR ${MINICONDA}
RUN pip install https://pypi.python.org/packages/source/p/pygrib/pygrib-2.0.1.tar.gz
RUN pip install boto3
RUN pip install PyYAML

#
# Install node
#
ENV NODE_ENGINE 	4.2.6
RUN mkdir ${MINICONDA}/node && cd ${MINICONDA}/node && wget https://nodejs.org/dist/v${NODE_ENGINE}/node-v${NODE_ENGINE}.tar.gz && tar -zxf node-v${NODE_ENGINE}.tar.gz
RUN cd ${MINICONDA}/node/node-v${NODE_ENGINE} && ./configure --prefix ${MINICONDA} && make && make install
RUN rm -rf ${MINICONDA}/node

# Topojson
RUN npm -g install topojson

# To find EPSG csv files
ENV GDAL_DATA ${MINICONDA}/share/gdal

