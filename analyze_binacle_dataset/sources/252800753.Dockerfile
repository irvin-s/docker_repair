FROM python:2.7-alpine  
MAINTAINER Dorinel Filip <dorinel.filip@beia.ro>  
  
EXPOSE 80  
COPY requirements.txt /tmp  
RUN pip install -r /tmp/requirements.txt  
COPY supervisord.conf /usr/local/etc/  
COPY src /srv/notify/  
  
CMD ["/usr/local/bin/supervisord", "-c", "/usr/local/etc/supervisord.conf"]  

