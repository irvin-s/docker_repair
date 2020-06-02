FROM google/cloud-sdk  
  
WORKDIR /tmp  
RUN wget https://bootstrap.pypa.io/get-pip.py && \  
python get-pip.py && \  
pip install httplib2 && \  
pip install \--upgrade google-api-python-client  
  
CMD ["/bin/bash"]  

