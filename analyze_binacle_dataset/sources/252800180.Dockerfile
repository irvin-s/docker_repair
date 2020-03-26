# from http://www.jujens.eu/posts/en/2015/May/24/deploy-glassfish-docker/  
FROM glassfish:latest  
  
COPY start.sh /  
  
EXPOSE 8080  
ENTRYPOINT ["/start.sh"]  

