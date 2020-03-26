FROM centos  
  
MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)  
  
# Dependencies  
RUN yum install -y git vim curl  
  
# Build Dev Essentials  
RUN yum install -y tar make perl-CPAN bzip2 patch gcc automake autoconf  
RUN yum install -y openssl openssl-devel  
  
# Environment  
ENV SHELL /bin/bash  
ENV HOME /root  
  
# Install cpanm  
RUN cpan App::cpanminus  
RUN cpanm install --force Pod::Usage  
  
# duckpan and ddg  
RUN cpanm install --force App::DuckPAN  
  
RUN duckpan DDG  
  

