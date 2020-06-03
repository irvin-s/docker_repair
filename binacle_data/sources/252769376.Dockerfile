FROM nginx:1.13.6  
COPY data/execute.sh /home/execute.sh  
COPY data/nginx.conf /etc/nginx/nginx.conf  
  
RUN chmod +x /home/execute.sh \  
&& apt-get update \  
&& apt-get install -y inotify-tools  
  
EXPOSE 80 443  
CMD ["/bin/bash", "/home/execute.sh"]  

