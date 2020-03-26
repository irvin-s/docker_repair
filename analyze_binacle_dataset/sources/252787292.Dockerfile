FROM ubuntu:latest  
  
# package install  
RUN apt-get update && apt-get install -y \  
sudo \  
nano \  
python-pip  
  
EXPOSE 8000  

