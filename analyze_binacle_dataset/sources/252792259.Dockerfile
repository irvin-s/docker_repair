FROM centos:latest  
  
WORKDIR /work  
VOLUME /work  
  
ENV SEX_PKG sextractor-2.19.5-1.x86_64.rpm  
  
RUN curl -q -O http://www.astromatic.net/download/sextractor/$SEX_PKG && \  
rpm --install --quiet $SEX_PKG  
  
ENTRYPOINT ["/usr/bin/sex"]  
CMD ["--help"]  
  

