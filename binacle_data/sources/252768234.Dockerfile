FROM adityapb/cycamore:bw  
  
COPY . /rickshaw  
WORKDIR /rickshaw  
RUN pip3 install python-json-logger  
RUN pip3 install docker  
RUN apt-get install -y --force-yes hdf5-tools  
RUN python setup.py install  
ENV PYTHONPATH="/cyclus/build"  

