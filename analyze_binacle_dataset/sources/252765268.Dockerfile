FROM java  
  
WORKDIR /tmp  
RUN wget https://ferret-lang.org/builds/ferret.jar  
RUN apt-get update && apt-get install -y g++  
  
WORKDIR /code  
ENTRYPOINT ["java", "-jar", "/tmp/ferret.jar", "-ci"]  

