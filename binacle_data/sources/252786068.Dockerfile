FROM dlip/monkeywrench-base  
  
ADD roles/aws /roles/aws  
RUN /roles/aws/install.sh  

