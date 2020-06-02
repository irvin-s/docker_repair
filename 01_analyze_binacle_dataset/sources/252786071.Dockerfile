FROM dlip/monkeywrench-base  
  
ADD roles/aws /roles/aws  
RUN /roles/aws/install.sh  
  
ADD roles/terraform /roles/terraform  
RUN /roles/terraform/install.sh  

