FROM debian:jessie  
  
RUN apt-get update && apt-get install -y hugs98 vim nano  
ADD . /code  
CMD hugs  

