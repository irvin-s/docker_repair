# Base  
FROM asgard/spark-python:latest  
  
# Add all code  
ADD . /root/asgard  
  
# working directory  
WORKDIR /root/asgard  
  
# install requirements and asgard package  
RUN pip install -r requirements.txt && \  
pip install -e .  
  
# Execute pipeline  
CMD [/sbin/init_script]  
  

