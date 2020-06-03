FROM ashander/rcpp  
MAINTAINER "Jaime Ashander" jashander@ucdavis.edu  
  
RUN install2.r --error \  
-r "https://cran.rstudio.com" \  
rstan \  
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds  

