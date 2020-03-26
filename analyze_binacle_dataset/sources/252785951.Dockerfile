FROM kaixhin/cuda-torch  
MAINTAINER Daniel Petti  
  
# Install packages needed to run the demo code.  
RUN apt-get update  
RUN apt-get install -y libhdf5-dev cmake  
  
RUN luarocks install qtlua  
  
# Install torch-hdf5  
RUN luarocks install hdf5  

