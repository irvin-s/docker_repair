FROM dlip/monkeywrench-base  
  
ADD roles/ssh /roles/ssh  
RUN /roles/ssh/install.sh  
  
ADD roles/aws /roles/aws  
RUN /roles/aws/install.sh  
  
ADD roles/ansible /roles/ansible  
RUN /roles/ansible/install.sh  

