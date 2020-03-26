FROM codingame/rust:1.15  
COPY build.sh /project/build  
COPY entrypoint.sh /  
  
RUN chmod +x /project/build /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

