# See https://github.com/dougmet/dockerR r-base  
FROM dougmet/r-base:3.1.2  
## Who made this  
MAINTAINER "Doug Ashton" dashton@mango-solutions.com  
  
# Install the gsl system dependencies  
RUN apt-get -y install libgsl0ldbl=1.16*1 libgsl0-dev=1.16*  
  
# Install R package manifest  
COPY loadPackages.R /tmp/  
COPY packages.csv /tmp/  
RUN Rscript /tmp/loadPackages.R  
  
CMD ["R"]  

