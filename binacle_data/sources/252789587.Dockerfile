FROM java:8  
WORKDIR /opt/countries  
ADD countries-assembly-1.0.1.jar countries-assembly-1.0.1.jar  
EXPOSE 8080  
CMD java -jar countries-assembly-1.0.1.jar  

