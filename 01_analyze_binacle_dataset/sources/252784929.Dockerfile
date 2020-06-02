FROM nginx:latest  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
RUN apt-get update && apt-get -y install python python-pip  
  
RUN pip install awscli  
  
ADD ./entrypoint.sh /app/docker/entrypoint.sh  
  
RUN chmod +x /app/docker/entrypoint.sh  
  
COPY maintenance.html /app/docker/maintenance.html  
  
ENTRYPOINT ["/app/docker/entrypoint.sh"]  

