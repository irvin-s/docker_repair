FROM rocker/r-ver:3.3.2  
RUN apt-get update -qq && apt-get -y --no-install-recommends install \  
libxml2-dev \  
libssl-dev \  
libcurl4-openssl-dev \  
&& . /etc/environment \  
&& install2.r --error \  
\--repos 'http://www.bioconductor.org/packages/release/bioc' \  
\--repos $MRAN \  
\--deps TRUE \  
plumber devtools  
# As with the tidyverse rocker image --deps TRUE downloads all of plumber's  
# Suggests dependencies. This has testthat, XML, rmarkdown, PKI and base64enc  
# most of which sound useful for an API service.  
# devtools is added to make installing packages later easier  
# @TODO. Should we add ggplot2 seeing as many services will want that?  
# Add a non-root user who will launch the apps  
RUN useradd plumber \  
&& mkdir /home/plumber \  
&& chown plumber:plumber /home/plumber \  
&& addgroup plumber staff  
  
# Add some default app. @TODO Should plumbapp.sh not be an R script?  
ADD demo.R /apps/demo.R  
ADD plumbapp.R /plumbapp.R  
RUN chmod 700 /plumbapp.R \  
&& chgrp -R staff /apps  
  
# Plumb your app into 8000  
EXPOSE 8000  
CMD ["Rscript", "/plumbapp.R", "-p", "8000", "/apps/demo.R"]  

