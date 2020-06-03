FROM java:7  
COPY HelloWorld.java /hello/HelloWorld.java  
WORKDIR /hello  
RUN javac HelloWorld.java  
VOLUME /hello  
ENTRYPOINT ["java"]  
CMD ["HelloWorld"]  

