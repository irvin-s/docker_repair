FROM python:3.4-alpine  
  
ADD provision.sh /tmp/provision.sh  
RUN /tmp/provision.sh  
  
CMD ["python"]  

