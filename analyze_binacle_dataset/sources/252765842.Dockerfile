FROM python:3.6  
RUN apt-get update  
RUN apt-get install -y python3-pip libav-tools nmap  
  
RUN mkdir /app  
  
WORKDIR /app  
ADD . .  
RUN python3 -m pip install -r requirements.txt  
  
ENTRYPOINT bash -c "bash docker-entrypoint.sh"

