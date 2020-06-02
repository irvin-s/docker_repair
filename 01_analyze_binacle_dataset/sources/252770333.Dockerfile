FROM dockerfile/nginx  
  
ONBUILD ADD ssl.crt /etc/ssl/  
ONBUILD ADD ssl.key /etc/ssl/  
  
# Define mountable directories.  
VOLUME ["/data", "/etc/nginx/sites-enabled", "/var/log/nginx"]  
  
# Define working directory.  
WORKDIR /etc/nginx  
  
# Define default command.  
CMD ["nginx"]  
  
# Expose ports.  
EXPOSE 80  
EXPOSE 443

