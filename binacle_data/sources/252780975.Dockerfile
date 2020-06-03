from bailaohe/statoy:base  
  
ADD requirements.txt /requirements.txt  
  
# Install python related packages  
RUN pip3 --no-cache-dir install -r /requirements.txt && \  
rm -rf /root/.cache/pip  
  

