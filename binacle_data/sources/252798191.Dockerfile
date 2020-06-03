FROM python:3.5  
RUN apt-get update && \  
apt-get install -y nginx && \  
rm -rf /var/lib/apt/lists/*  
  
ADD ./requirements.txt /  
RUN pip install pip --upgrade  
RUN pip install -r requirements.txt  
  
WORKDIR /usr/src/app

