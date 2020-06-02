# Docker swarm consul notifier  
# Auto-registration/de-registration of Docker Swarm services in Consul  
# by hooking into Docker daemon event stream  
FROM frolvlad/alpine-python2  
  
USER root  
  
WORKDIR /app  
COPY . /app  
  
RUN pip install -r requirements.txt  
  
ENTRYPOINT ["python", "consul-notifier.py"]

