FROM rocker/rstudio  
MAINTAINER "Jaime Ashander" jashander@ucdavis.edu  
  
# needed for devtools  
RUN apt-get update && \  
apt-get install -y --fix-missing -t unstable --no-install-recommends \  
libssl-dev/unstable \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/  
## Install external dependencies.  
RUN install2.r --error \  
-r "https://cran.rstudio.com" \  
devtools \  
roxygen2 \  
testthat \  
Rcpp \  
RcppArmadillo \  
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds  

