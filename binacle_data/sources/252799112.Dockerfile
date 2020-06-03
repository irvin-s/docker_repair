FROM python:2.7  
ADD requirements.txt /root/  
RUN pip install -r /root/requirements.txt  
ADD templates/ /templates/  
ADD generate /root/  
ADD templates/ /root/templates/  
VOLUME /etc/nginx/conf.d /usr/share/nginx/html  
WORKDIR /root/  
  
ENTRYPOINT ["/root/generate"]

