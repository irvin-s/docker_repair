# Start from base Ubuntu image  
FROM ubuntu  
  
RUN apt-get update && apt-get install -y kismet gpsd  
  
WORKDIR /tmp/  
CMD kismet  

