FROM docker:stable-git  
  
RUN apk add --update --no-cache bash py-pip  
  
RUN pip install docker-compose  
  
COPY resources/* /root/  

