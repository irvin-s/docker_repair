#  
#  
#  
# Pull base image.  
FROM ubuntu:17.10  
# Install.  
RUN \  
apt-get update && \  
apt-get install -y \  
mercurial \  
doxygen \  
g++ \  
gobjc++ \  
gnustep-devel \  
lcov \  
python \  
python-pip \  
libgtest-dev \  
ant \  
cmake \  
swig \  
dcmtk && \  
pip install breathe && \  
pip install sphinx_rtd_theme && \  
pip install dropbox  
  
  
  

