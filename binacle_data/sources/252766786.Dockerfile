FROM ubuntu:14.04  
# Ensure packages are up to date  
RUN apt-get -qq update  
  
# Install pre-reqs  
RUN apt-get -qq install \  
build-essential \  
git \  
libfuse-dev \  
libcurl4-openssl-dev \  
libxml2-dev \  
mime-support \  
automake \  
libtool  
  
# Check out S3FS  
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git  
  
# Build and install S3FS  
RUN cd s3fs-fuse \  
&& ./autogen.sh \  
&& ./configure --prefix=/usr --with-openssl \  
&& make \  
&& make install

