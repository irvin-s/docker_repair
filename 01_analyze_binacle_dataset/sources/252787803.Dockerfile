# Dockerfile for generating a linux image  
FROM rocker/rstudio  
MAINTAINER Christian Panse <cp@fgcz.ethz.ch>  
  
RUN echo "install.packages(c('knitr', 'testthat', 'dplyr'))" \  
| R --no-save \  
&& apt-get update \  
&& apt-get install git ssh -y \  
&& git clone https://github.com/protViz/bibliospec.git \  
&& R CMD build bibliospec \  
&& R CMD check bibliospec*z \  
&& R CMD INSTALL bibliospec*z  
  

