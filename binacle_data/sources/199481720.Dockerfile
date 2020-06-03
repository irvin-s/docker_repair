FROM python:3.6-alpine
LABEL MAINTAINER="Aleksandar Jelenak, The HDF Group"
ARG HDF5_SRC_URL=http://www.hdfgroup.org/ftp/HDF5/releases
ARG HDF5_MAJOR_REL=hdf5-1.10
ARG HDF5_MINOR_REL=5
RUN apk add --no-cache --virtual .build-deps \
        coreutils \
        gcc \
        g++ \
        libc-dev \
        make \
        zlib-dev \
        curl \
        git \
# Build and install HDF5 library...
 && cd /tmp \
 && curl -L -O ${HDF5_SRC_URL}/${HDF5_MAJOR_REL}/${HDF5_MAJOR_REL}.${HDF5_MINOR_REL}/src/${HDF5_MAJOR_REL}.${HDF5_MINOR_REL}.tar.gz \
 && tar -xzvf ${HDF5_MAJOR_REL}.${HDF5_MINOR_REL}.tar.gz \
 && cd ${HDF5_MAJOR_REL}.${HDF5_MINOR_REL} \
 && ./configure --prefix=/usr/local \
 && make -j "$(nproc)" \
 && make install \
 && cd .. \
 && rm -rf ${HDF5_MAJOR_REL}.${HDF5_MINOR_REL}* \
# Install h5py Python dependencies...
 && pip --no-cache-dir install -U pip \
 && pip --no-cache-dir install numpy Cython six pkgconfig \
# Install h5py from source...
 && pip --no-cache-dir install git+https://github.com/ajelenak-thg/h5py.git@chunk-query \
 && cd /usr/local/bin \
 && curl -O https://raw.githubusercontent.com/ajelenak-thg/h5py/chunk-query/examples/store_info.py \
 && apk del .build-deps

# Create a volume for external files...
RUN mkdir /data
VOLUME /data
WORKDIR /data

ENTRYPOINT ["python", "/usr/local/bin/store_info.py"]
CMD ["--help"]
