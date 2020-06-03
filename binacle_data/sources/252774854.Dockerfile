FROM bausmeier/centrifuge:logging  
  
USER root  
ADD . /src  
RUN cd /src && \  
python setup.py install && \  
rm -r /src  
  
USER centrifuge  
RUN mkdir /tmp/.python-eggs  
ENV PYTHON_EGG_CACHE /tmp/.python-eggs  
ENV CENTRIFUGE_STORAGE centrifuge_mongodb.Storage  

