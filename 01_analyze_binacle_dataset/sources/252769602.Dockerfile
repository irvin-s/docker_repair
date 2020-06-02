FROM maven:3.5.2-jdk-8-alpine  
  
COPY . /chat-server  
  
RUN cd /chat-server && mvn package  
  
RUN ["chmod", "+x", "/chat-server/docker-entrypoint.sh"]  
  
ENTRYPOINT ["chat-server/docker-entrypoint.sh"]  
  
CMD ["4040"]

