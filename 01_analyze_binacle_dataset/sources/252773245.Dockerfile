#######################################################  
# Base image with my common software and configuration  
#######################################################  
FROM rocker/r-base  
MAINTAINER Brandon Holt <holt.bg@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y \  
make \  
texlive-fonts-recommended \  
texlive-humanities \  
texlive-latex-extra \  
texinfo \  
zsh && \  
apt-get install -y -t unstable \  
libcairo2-dev \  
libmysqlclient-dev \  
libsqlite3-dev \  
libcurl4-openssl-dev \  
libssl-dev \  
libxml2-dev  
  
RUN install2.r --error \  
ggplot2 \  
devtools \  
plyr \  
dplyr \  
reshape2 \  
sitools \  
jsonlite \  
yaml \  
sqldf \  
RMySQL \  
scales \  
Unicode \  
extrafont  
  
RUN apt-get install -y zsh  
  
ENV USER root  
  
VOLUME /src  
WORKDIR /src  
  
CMD ["R"]  

