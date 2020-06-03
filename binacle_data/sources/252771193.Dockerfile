FROM aimad/projetdockerhub  
  
RUN rm /var/www/html/index.html  
  
COPY src/assets/index.html /var/www/html/  
  
CMD apachectl -e info -DFOREGROUND  
  

