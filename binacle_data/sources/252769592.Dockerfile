# get the base image, this one has R, RStudio and pandoc  
FROM rocker/verse:latest  
  
LABEL maintainer="ctull17@gmail.com"  
  
COPY . /qcReport  
  
# go into the repo directory  
RUN apt-get update \  
  
&& . /etc/environment \  
  
# install package deps from MRAN repo specified in base container  
&& R -e "install.packages('flexdashboard'); install.packages('d3heatmap');" \  
&& R -e "install.packages('dbplyr');" \  
  
# build this package  
&& R -e "devtools::install('/qcReport', dep=TRUE)" \  

