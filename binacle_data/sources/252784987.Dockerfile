FROM ubuntu  
  
ENV PYTHONUNBUFFERED 1  
ADD requirements.txt /root/requirements.txt  
  
RUN apt-get update && \  
apt-get -y install python3 python3-pip wget && \  
pip3 install -r /root/requirements.txt && rm -f /root/requirements.txt && \  
wget -O- https://get.docker.com | bash && \  
apt-get -y purge python3-pip wget && \  
apt-get clean  
  
ADD LICENSE /root/codersos_image_server/LICENSE  
ADD codersos_image_server /root/codersos_image_server  
  
WORKDIR /root  
CMD ["python3", "-m", "codersos_image_server.app"]

