FROM python:2.7-onbuild  
ENTRYPOINT ["/start"]  
  
COPY start /start  

