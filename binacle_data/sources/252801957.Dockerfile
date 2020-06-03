FROM postgres:8.4  
  
RUN apt-get update -q && apt-get install -y libc6  

