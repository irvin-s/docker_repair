FROM jenkinsci/jnlp-slave  
  
# Metadata  
LABEL org.label-schema.vcs-url="https://github.com/derwasp/jenkins-jnlp" \  
org.label-schema.docker.dockerfile="/Dockerfile"  
  
USER root  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
g++ \  
gcc \  
libc6-dev \  
make \  
jq \  
&& rm -rf /var/lib/apt/lists/*  

