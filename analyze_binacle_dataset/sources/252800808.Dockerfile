FROM ubuntu  
  
RUN apt-get -y update && apt-get install -y iputils-ping  
  
CMD ping 127.0.0.1 -c 20  

