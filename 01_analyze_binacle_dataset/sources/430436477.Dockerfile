# A Fiona, Rasterio, and Shapely Image
# ====================================
# All from source, as well as GDAL and GEOS, for testing and debugging.

FROM ubuntu
MAINTAINER Sean Gillies <sean.gillies@gmail.com>

# Install the Ubuntu packages.
RUN apt-get update
RUN apt-get install -y git python-pip cython python-numpy python-pytest python-nose wget vim

# Set the locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# More environment variables.
ENV LD_LIBRARY_PATH /usr/local/lib
WORKDIR /home

# Install GEOS.
RUN wget http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
RUN tar -xjf geos-3.4.2.tar.bz2
RUN cd geos-3.4.2; ./configure --enable-debug; make; make install

# Install GDAL.
RUN wget http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz
RUN tar -xzf gdal-1.11.0.tar.gz
RUN cd gdal-1.11.0; ./configure --enable-debug; make; make install

# Clone Fiona and install locally.
RUN git clone https://github.com/Toblerity/Fiona.git
RUN cd Fiona; pip install -e .

# Clone Rasterio and install locally.
RUN git clone https://github.com/mapbox/rasterio.git
RUN cd rasterio; pip install -e .

# Clone Shapely and install locally.
RUN git clone https://github.com/Toblerity/Shapely.git
RUN cd Shapely; pip install -e .

