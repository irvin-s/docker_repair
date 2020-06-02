FROM ubuntu:latest  
  
# Install dependencies  
RUN apt-get update && \  
apt-get install -y git gdal-bin python-gdal libfftw3-dev cmake  
  
ADD install.sh /bin/install.sh  
  
VOLUME [ "/LSDTopoTools" ]  
  
WORKDIR /LSDTopoTools  
  
CMD [ "/bin/bash" ]  

