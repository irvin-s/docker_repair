# From Shippable offical  
FROM drydock/u14phpall:prod  
  
MAINTAINER Milan Sulc <sulcmil@gmail.com>  
  
# Clean lists  
RUN apt-get clean && apt-get autoremove  
  
# Add our files  
ADD . /econea  
  
# Run our install  
RUN /econea/install.sh  

