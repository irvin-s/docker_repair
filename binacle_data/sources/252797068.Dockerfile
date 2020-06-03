FROM debian:jessie  
RUN apt-get update && apt-get install -y python-pip openssh-client  
WORKDIR /opt/marina/web  
ADD requirements.txt /opt/marina/web/requirements.txt  
RUN pip install pip --upgrade  
RUN pip install -r requirements.txt  
  
ADD . /opt/marina/web  
  
CMD /usr/bin/python -u marina_web.py  
  
EXPOSE 5000  

