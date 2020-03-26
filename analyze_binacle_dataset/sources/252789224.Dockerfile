FROM r-base:latest  
MAINTAINER eterna2 <eterna2@hotmail.com>  
  
RUN apt-get update && apt-get install -y \  
automake \  
autotools-dev \  
g++ \  
git \  
libcurl4-gnutls-dev \  
libfuse-dev \  
libssl-dev \  
libxml2-dev \  
make \  
pkg-config \  
supervisor \  
&& git clone https://github.com/s3fs-fuse/s3fs-fuse.git \  
&& cd s3fs-fuse/ && ./autogen.sh && ./configure && make && make install \  
&& apt-get clean  
  
WORKDIR /home  
ENV R_LIBS="/home/rlib"  
COPY config/fuse.conf /etc/fuse.conf  
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
COPY scripts/runS3fs.sh scripts/runS3fs.sh  
COPY scripts/setup.R scripts/setup.R  
COPY scripts/setupBio.R scripts/setupBio.R  
COPY scripts/setupPackages.R scripts/setupPackages.R  
RUN chmod +x scripts/runS3fs.sh  
  
COPY scripts/cmd.sh /usr/local/bin/cmd  
RUN chmod +x /usr/local/bin/cmd  
  
COPY packages /home/packages  
COPY rscripts /home/rscripts  
  
RUN mkdir /home/temp  
RUN mkdir /home/rlib  
RUN Rscript -e '.libPaths( c("/home/rlib",.libPaths()) )'  
  
WORKDIR /home/rscripts  
CMD ["/usr/local/bin/cmd"]  

