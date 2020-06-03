FROM busybox  
  
ADD docker-version.txt .  
  
ENTRYPOINT ["cat", "docker-version.txt"]  

