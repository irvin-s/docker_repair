FROM sstarcher/sensu  
  
ADD client-install.sh /client-install.sh  
RUN /client-install.sh  

