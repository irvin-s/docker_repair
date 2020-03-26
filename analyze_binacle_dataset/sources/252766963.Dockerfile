FROM rocker/hadleyverse:latest  
MAINTAINER Albert Z Wang <albert_z_wang@harvard.edu>  
  
RUN apt-get update \  
&& apt-get install -y libssh2-1-dev \  
&& r -e 'install.packages("git2r", type = "source")' \  
&& install2.r --error \  
lme4 \  
&& rm -rf /var/lib/apt/lists/ \  
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds  
  

