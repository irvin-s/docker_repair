FROM vault:0.10.1  
ADD ./vault-unseal.sh /vault-unseal.sh  
RUN chmod a+x /vault-unseal.sh  
  
CMD ["/bin/sh", "/vault-unseal.sh"]  

