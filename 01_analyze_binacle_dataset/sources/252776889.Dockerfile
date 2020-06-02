FROM rocker/rstudio  
  
MAINTAINER "Christian Diener <mail@cdiener.com>"  
USER root  
  
COPY . /tmp/dycone  
  
RUN apt-get update && apt-get install -y libglpk-dev libgmp-dev libxml2-dev  
  
RUN printf 'install.packages(c("devtools", "igraph", "deSolve"))\n\  
source("https://bioconductor.org/biocLite.R")\n\  
biocLite("BiocInstaller")\n\  
setRepositories(ind=1:2)\n\  
devtools::install_deps("/tmp/dycone", dependencies = TRUE)\n\  
devtools::install("/tmp/dycone")' | Rscript - && rm -rf /tmp/*  
  
USER rstudio  

