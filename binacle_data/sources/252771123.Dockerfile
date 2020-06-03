FROM java:8  
COPY MultiThreadChatClient.java /var/www/java/MultiThreadChatClient.java  
WORKDIR /var/www/java  
RUN javac MultiThreadChatClient.java  
  
CMD ["java", " MultiThreadChatClient"]  

