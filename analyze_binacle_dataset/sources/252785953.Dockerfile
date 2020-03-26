FROM gw000/keras:2.1.4-py2-tf-gpu  
MAINTAINER Daniel Petti  
  
# Install packages that we need to run code.  
RUN apt-get update && apt-get install -y python-opencv graphviz  
  
RUN pip install pyaml pydot-ng h5py  

