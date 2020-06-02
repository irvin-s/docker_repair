FROM python:3.6-slim  
  
RUN pip install pyyaml requests  
  
ADD . /concourse-bitbucket-resource  
  
RUN pip install -r /concourse-bitbucket-resource/requirements.txt  
  
RUN apt-get update && apt-get install -y git jq  
  
RUN cd /concourse-bitbucket-resource && PYTHONPATH=. py.test  
  
ADD scripts /opt/resource  
  
RUN chmod +x /opt/resource/*  

