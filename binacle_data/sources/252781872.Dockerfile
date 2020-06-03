#FROM ubuntu:16.04  
FROM debian  
  
  
# Create folder for application  
RUN mkdir /app  
  
# Update apt sources and extra programs (python:slim)  
RUN apt update  
RUN apt install -y git bash python3 python3-pip nano vim screen microcom  
  
# Dependency for serial communication  
RUN pip3 install pyserial  
  
# Add and run application  
ADD application.py /app/application.py  
ADD uboot.py /app/uboot.py  
  
# Run application at startup  
CMD [ "python3", "/app/application.py" ]  

