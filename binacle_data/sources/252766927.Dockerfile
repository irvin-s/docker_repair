FROM openjdk  
EXPOSE 7789  
RUN mkdir /usr/src/myapp  
COPY ./snake_online_1.jar /usr/src/myapp  
WORKDIR /usr/src/myapp  
#RUN java -jar /usr/src/myapp/snake_online_1.jar snake_server.jar  
CMD ["java","-jar","/usr/src/myapp/snake_online_1.jar"]  
  

