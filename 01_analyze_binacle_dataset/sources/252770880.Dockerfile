FROM jenkinsci/jnlp-slave  
MAINTAINER aghassabian <aghassabian@inocybe.com>  
  
USER root  
  
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1  
ENV PYTHONIOENCODING=UTF-8  
# Install Default packages  
RUN apt-get update && \  
apt-get install -y \  
ssh \  
python \  
python3 \  
python-pip \  
python3-pip  

