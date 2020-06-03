FROM tiangolo/uwsgi-nginx-flask:flask  
  
WORKDIR /app  
  
RUN pip install --upgrade pip && pip install Celery  
  
# CMD pip install -r requirements.txt && /usr/bin/supervisord  
COPY init_app.sh /etc/auge.digital/init_app.sh  
RUN chmod 0700 /etc/auge.digital/init_app.sh  
  
ENV APPCELERY pipebot  
  
CMD /etc/auge.digital/init_app.sh  
  

