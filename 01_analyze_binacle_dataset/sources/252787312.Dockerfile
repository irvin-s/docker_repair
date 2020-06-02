FROM openwhisk/dockerskeleton  
  
ENV FLASK_PROXY_PORT 8080  
# Install dependencies  
ADD requirements.txt /action/requirements.txt  
RUN cd /action; pip install -r requirements.txt  
  
# Add all source assets  
ADD . /action  
  
ADD grainbin_admin_tasks.py /action/exec  
RUN chmod +x /action/exec  
  
CMD ["/bin/bash", "-c", "cd actionProxy && python -u actionproxy.py"]  

