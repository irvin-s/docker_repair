FROM jupyter/r-notebook  
  
MAINTAINER cdeck3r  
  
# for install purposes  
USER root  
  
#  
# pre-requisites  
RUN apt-get update && apt-get install -y \  
jags \  
libxml2-dev \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
#  
# Install R packages for Bayes  
#  
ADD installBayes.R /tmp/installBayes.R  
#RUN R CMD BATCH /tmp/installBayes.R  
RUN Rscript /tmp/installBayes.R  
  
# Switch back to default user  
USER $NB_USER  

