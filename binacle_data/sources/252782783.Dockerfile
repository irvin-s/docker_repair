# Pull base image.  
FROM docker.io/python  
  
WORKDIR /data  
COPY . /data  
RUN pip install .  
  
CMD ["hca-filter"]  

