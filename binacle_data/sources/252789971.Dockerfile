FROM bioboxes/biobox-minimal-base  
  
MAINTAINER Stefan Janssen, stefan.m.janssen@gmail.com  
  
SHELL ["/bin/bash", "-c"]  
  
COPY image/ /usr/local  
  
RUN /usr/local/install.sh  
  
COPY src/ /usr/local/bin  
  
ENV SCHEMA /usr/local/schema.yaml  
  
ENV OUTPUT /bbx/output  
  
ENV BIOBOX_EXEC execute_biobox.sh  
  
ENV TASKFILE /usr/local/Taskfile  

