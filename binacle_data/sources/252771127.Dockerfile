FROM java:8  
COPY MultiThreadChatServer.java /var/www/java/MultiThreadChatServer.java  
WORKDIR /var/www/java  
RUN javac MultiThreadChatServer.java  
  
CMD ["java", "MultiThreadChatServer"]  

