FROM haproxy:1.5  
ADD start.sh /usr/local/bin/start.sh  
  
CMD ["start.sh"]  

