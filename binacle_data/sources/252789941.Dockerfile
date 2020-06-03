FROM ubuntu:16.04  
LABEL maintainer="Cameron Morris"  
RUN apt-get update  
  
# Install dependencies  
RUN apt-get install -y \  
git \  
xorriso \  
isolinux \  
make  
  
CMD ["/bin/bash"]  

