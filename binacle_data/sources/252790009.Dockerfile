FROM debian:stretch  
MAINTAINER Camil Staps <info@camilstaps.nl>  
  
RUN apt-get update && apt-get install -qq libc6-dev  
  
COPY install_clean.sh /opt/install_clean.sh  
COPY install_clean_nightly.sh /opt/install_clean_nightly.sh  
COPY uninstall_clean.sh /opt/uninstall_clean.sh  
  
ENV CLEAN_HOME /opt/clean  
ENV PATH /opt/clean/bin:/opt/clean/exe:/opt:$PATH  
  
CMD ["clm"]  

