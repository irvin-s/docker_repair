# Use the latest cut of alpine  
FROM alpine:latest  
  
# update apk lib, install deps, install ansible and install pywinrm.  
# also install docker libraries and install crypto module which gives good  
# performance gains on ansible-vault (particularly when using lots of vaulted  
# files).  
RUN apk update && apk add python py-pip python-dev gcc && \  
apk add libc-dev libffi-dev openssl-dev make && \  
pip install cffi && \  
pip install ansible pywinrm cryptography  
  
# Inventory file (defaults to ./hosts)  
ENV INVENTORY hosts  
  
# Test variable  
ENV TEST test  
  
# Setup working directory structure (/data)  
# Create /data as a volume  
VOLUME /data  
  
# Use /data as our working directory.  
WORKDIR /data  
  
# Fire up ansible, using /data/playbook.yaml as the default playbook.  
CMD ansible-playbook -i ${INVENTORY} playbook.yaml  

