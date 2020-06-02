FROM nginx:latest  
  
COPY dockerit.sh /projects/project/  
COPY requirements.txt /projects/project/  
  
ONBUILD COPY . /projects/project/runbook  
ONBUILD WORKDIR /projects/project/runbook  
ONBUILD RUN sh -ex /projects/project/dockerit.sh  

