FROM haproxy:1.5  
ADD wait-for-file.sh /  
RUN chmod +x /wait-for-file.sh  
  

