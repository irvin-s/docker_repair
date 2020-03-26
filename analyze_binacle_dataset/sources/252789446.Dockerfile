FROM phusion/baseimage  
MAINTAINER Dan Leehr <dan.leehr@duke.edu>  
  
# Install dependencies  
RUN apt-get update && apt-get install -y \  
curl \  
libgomp1  
  
# Configure version and source  
ENV STAR_VERSION STAR_2.4.1c  
ENV STAR_RELEASE_URL https://github.com/alexdobin/STAR/archive/  
ENV STAR_DIR /opt/star  
  
# Make destination directory  
RUN mkdir -p $STAR_DIR  
  
# Download & extract archive - Repo includes binaries for linux  
RUN curl -SL ${STAR_RELEASE_URL}${STAR_VERSION}.tar.gz | tar -xzC $STAR_DIR  
ENV PATH $STAR_DIR/STAR-${STAR_VERSION}/bin/Linux_x86_64/:$PATH  
  
CMD ["STAR"]  

