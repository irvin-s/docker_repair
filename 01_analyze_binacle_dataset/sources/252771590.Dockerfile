FROM python:2.7  
ADD js /app/js  
ADD Simulator /app/Simulator  
ADD Examples /app/Examples  
ADD start_server_mac.sh /app/start_server.sh  
  
WORKDIR /app  
EXPOSE 8888  
CMD /app/start_server.sh  

