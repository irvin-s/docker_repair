FROM java:7  
RUN apt-get update  
COPY src/HelloWorld.java /  
RUN javac HelloWorld.java  
RUN apt-get install -y wget  
RUN mkdir /data/myvol -p  
RUN echo "put some text here" > /data/myvol/test  
EXPOSE 80 8080  
VOLUME /data/myvol  
#ENTRYPOINT ["java", "HelloWolrd"]  

