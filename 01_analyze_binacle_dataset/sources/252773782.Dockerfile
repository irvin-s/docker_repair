FROM rocker/geospatial:latest  
MAINTAINER "Hiroaki Yutani" yutani.ini@gmail.com  
  
COPY packages.list packages.list  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
openssh-client \  
openjdk-7-jdk \  
imagemagick \  
libbz2-dev \  
libcairo2-dev \  
libxt-dev  
  
RUN install2.r \  
\--error \  
\--deps TRUE \  
\--repos 'https://cloud.r-project.org/' \  
\--repos 'http://www.bioconductor.org/packages/release/bioc' \  
$(cat packages.list)

