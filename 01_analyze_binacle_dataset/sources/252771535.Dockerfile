FROM akeneo/ansible:2.5  
  
RUN pip install molecule==2.12 && pip install apache-libcloud

