FROM debian:stretch  
  
RUN apt-get update && apt-get install -y gcc && apt-get clean  

