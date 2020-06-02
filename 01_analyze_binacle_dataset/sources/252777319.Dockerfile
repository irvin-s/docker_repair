FROM cfljam/pyrat  
  
MAINTAINER John McCallum john.mccallum@plantandfood.co.nz  
  
# Set noninterative mode  
ENV DEBIAN_FRONTEND noninteractive  
  
################## BEGIN INSTALLATION ######################  
  
## Install R packages for Genetics  
ADD R-requirements.txt /tmp/  
RUN install2.r --error $(cat /tmp/R-requirements.txt) \  
&& Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("Gviz")'  
  
  
##########################################  
  
### Launch ipynb as default  
  
CMD ipython notebook --ip=0.0.0.0 \--port=8888 \--no-browser  
  
##################### INSTALLATION END #####################  
  
## TEST  
WORKDIR /tmp  
ADD test-suite.sh /tmp/test-suite.sh  
RUN chmod a+x ./test-suite.sh  
RUN sh -c ./test-suite.sh  
  
## Clean up  
RUN rm -rf /tmp/*  

