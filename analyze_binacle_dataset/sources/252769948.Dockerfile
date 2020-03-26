FROM artefact/pacman-base:latest  
MAINTAINER Artefact "infrastructure@artefact.is"  
# install private requirements and code  
COPY requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt && rm /tmp/requirements.txt  
  
ENV PYTHONPATH=/opt/pacman  
ENV VAULT_CACERT=/opt/pacman/conf/ca-certificates.crt  
ENV VAULT_ADDR=https://vault.infra.artefact.is:8200  
# Set region name once for all  
RUN aws configure set default.region eu-west-1  
  
WORKDIR /opt/pacman  
COPY . /opt/pacman  

