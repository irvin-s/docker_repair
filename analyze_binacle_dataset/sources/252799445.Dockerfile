FROM dhspence/docker-baseimage  
MAINTAINER David H. Spencer <dspencer@wustl.edu>  
  
LABEL \  
description="Haloplex QC scripts"  
  
COPY CalculateCoverageQC.072617.pl /usr/local/bin/  
COPY CoveragePlots.R /usr/local/bin/  
  
RUN apt-get update && apt-get install -y --no-install-recommends locales && \  
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \  
locale-gen en_US.UTF-8 && \  
LC_ALL=en_US.UTF-8 && \  
LANG=en_US.UTF-8 && \  
/usr/sbin/update-locale LANG=en_US.UTF-8  
  
RUN cpan install Statistics::Basic  
RUN cpan install JSON  
  
RUN apt-get install -y bc  

