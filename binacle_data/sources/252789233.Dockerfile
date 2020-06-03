FROM nginx  
  
COPY nginx.conf.template /  
COPY startup.sh /  
COPY cert.pem key.pem /etc/ssl/  
  
RUN chmod +x /startup.sh  
  
CMD ["/startup.sh"]  
  
EXPOSE 80  

