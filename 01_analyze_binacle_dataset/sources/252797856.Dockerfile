FROM python:3.5.2-alpine  
  
WORKDIR /app/src  
  
# install requirements  
# this way when you build you won't need to install again  
# and since COPY is cached we don't need to wait  
COPY requirements.txt /tmp/requirements.txt  
RUN pip3 install -r /tmp/requirements.txt  
  
COPY src /app/src  
COPY run.sh /run.sh  
  
# App port number is configured through the gunicorn config file  
CMD ["/run.sh"]  
  
#CMD ["gunicorn", "--config", "/src/gunicorn_config.py", "server:app"]  

