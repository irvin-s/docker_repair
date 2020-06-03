FROM nginx  
  
ENV SOCKET_SERVER socket_server  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY run.sh /  
  
CMD ["bash", "/run.sh"]  

