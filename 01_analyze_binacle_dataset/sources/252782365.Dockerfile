FROM nginx  
  
ADD bin/ /usr/sbin/  
RUN configure-nginx.sh  
  
VOLUME ["/var/log/nginx", "/etc/nginx/sites-templates"]  
EXPOSE 80 443  
WORKDIR /etc/nginx  
  
ENTRYPOINT ["entrypoint.sh"]  
CMD ["nginx"]  

