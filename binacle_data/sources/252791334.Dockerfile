FROM rocker/r-ver:latest  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
libcurl4-openssl-dev \  
zlib1g-dev \  
libssl-dev \  
libxml2-dev \  
libmariadb-client-lgpl-dev \  
libpq-dev \  
pandoc \  
pandoc-citeproc \  
qpdf  
  
  
RUN R -e "install.packages('MASS')"  
  
RUN R -e "install.packages('lattice')"  

