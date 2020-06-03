FROM openjdk  
  
RUN apt-get update \  
&& apt-get install -y libderby-java \  
&& apt-get install -y derby-tools  
  
RUN mkdir /db_data  
  
EXPOSE 1527  
CMD ["/usr/share/derby/NetworkServerControl", "start", "-h", "0.0.0.0"]  
  

