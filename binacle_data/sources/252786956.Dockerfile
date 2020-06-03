FROM bradleybossard/docker-common-devbox  
  
RUN apt-get update --fix-missing  
  
RUN apt-get install --yes goaccess nginx  

