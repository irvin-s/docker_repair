FROM dlip/monkeywrench-base  
  
ADD roles/ssh /roles/ssh  
RUN /roles/ssh/install.sh  
  

