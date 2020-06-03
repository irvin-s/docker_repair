FROM rocker/rstudio  
MAINTAINER Christian Panse <cp@fgcz.ethz.ch>  
  
RUN echo "install.packages(c('Rcpp', 'knitr'))" \  
| R --no-save \  
&& apt-get update \  
&& apt-get install git ssh -y \  
&& git clone https://github.com/protViz/protViz.git \  
&& R CMD build --no-build-vignettes protViz \  
&& R CMD INSTALL protViz_*gz; rm -rvf /protViz*  

