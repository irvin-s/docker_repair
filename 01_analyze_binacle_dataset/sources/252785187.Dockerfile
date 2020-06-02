FROM python:2.7-onbuild  
MAINTAINER tech@cogniteev.com  
  
RUN pip install .  
  
CMD ["cloud-dns", "server", "start"]  

