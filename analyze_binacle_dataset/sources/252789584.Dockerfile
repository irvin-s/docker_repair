FROM java:8  
WORKDIR /opt/airports/  
ADD airports-assembly-1.1.0.jar airports-assembly-1.1.0.jar  
EXPOSE 8080  
CMD java -jar airports-assembly-1.1.0.jar  

