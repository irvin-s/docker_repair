FROM perl  
  
ADD varaq-kling /var/aq/  
  
ENTRYPOINT [ "/var/aq/varaq-kling" ]  

