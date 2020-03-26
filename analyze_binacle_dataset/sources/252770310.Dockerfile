FROM ashander/rcpp  
# includes devtools, rcpp, rcpparmadillo  
MAINTAINER Jaime Ashander "jashander@ucdavis.edu"  
USER rstudio  
WORKDIR /home/rstudio  
  
RUN git clone https://github.com/ashander/phenoecosim \  
&& R -e "devtools::install_local('phenoecosim')"  
  
USER root  

