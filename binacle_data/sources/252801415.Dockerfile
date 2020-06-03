FROM nginx:1.9.5  
RUN apt-get update && \  
apt-get install -y python-pip && \  
pip install awscli  
  
COPY run-nginx.sh /usr/local/bin/run-nginx.sh  
RUN chmod 755 /usr/local/bin/run-nginx.sh  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
CMD ["/usr/local/bin/run-nginx.sh"]  

