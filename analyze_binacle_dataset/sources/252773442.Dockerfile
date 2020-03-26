FROM mongo:3.1  
RUN apt-get update && apt-get install -y zip  
  
ADD import.sh /usr/local/bin/import.sh  
  
RUN chmod +x /usr/local/bin/import.sh  

