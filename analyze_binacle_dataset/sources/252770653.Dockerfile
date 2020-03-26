FROM python:3.6  
RUN pip install "devpi-server<4.4" "devpi-web<3.3" "devpi<2.3" "pluggy<0.5"  
  
RUN mkdir /devpi  
WORKDIR /devpi  
  
EXPOSE 3141  
ENTRYPOINT "devpi-server"  
CMD "--start"  

