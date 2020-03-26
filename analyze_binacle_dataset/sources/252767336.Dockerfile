FROM nginx  
  
  
# Add the files  
ADD root /  
COPY docker-entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["nginx"]  
# Expose the ports for nginx  
EXPOSE 80 443  

