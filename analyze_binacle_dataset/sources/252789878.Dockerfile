FROM java:7u91-alpine  
  
ADD zookeeper-3.4.8 /  
EXPOSE 2181  
CMD ["sh","bin/zkServer.sh","start-foreground"]  

