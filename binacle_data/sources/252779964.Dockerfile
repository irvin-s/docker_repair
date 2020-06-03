FROM python:alpine  
  
MAINTAINER Carlos Sanz <carlos.sanzpenas@gmail.com>  
  
LABEL org.label-schema.vendor = "Personal" \  
org.label-schema.name = "Cisco Collab" \  
org.label-schema.version = "Alpine" \  
org.label-schema.docker.cmd = "docker run -it sanzcarlos/CiscoCollab" \  
org.label-schema.name = "Cisco Collab" \  
org.label-schema.build-date = "2018-05-08"  
  
RUN apk update && \  
apk upgrade && \  
apk add git && \  
git clone https://github.com/sanzcarlos/CiscoCollab /usr/src/CiscoCollab/ && \  
pip install -r /usr/src/CiscoCollab/requirements.txt  
  
WORKDIR /usr/src/CiscoCollab/  
  
CMD [ "python", "/usr/src/CiscoCollab/axl_cucm.py" ]  

