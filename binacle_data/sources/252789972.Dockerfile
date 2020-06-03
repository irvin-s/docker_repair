FROM bioboxes/biobox-minimal-base  
  
SHELL ["/bin/bash", "-c"]  
  
ENV INSTALL_DIR /usr/local/bin  
  
COPY image/ /usr/local  
  
RUN /usr/local/install.sh  
  
COPY src/ ${INSTALL_DIR}  
  
ENV SCHEMA /usr/local/schema.yaml  
  
ENV OUTPUT /bbx/output  
  
ENV BIOBOX_EXEC execute_biobox.sh  
  
ENV TASKFILE /usr/local/Taskfile  

