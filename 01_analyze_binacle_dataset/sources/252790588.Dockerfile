FROM carlosotgz/cuckoo:2.0.4a1  
  
MAINTAINER Carlos Ortigoza Dempster <carlos.otgz@gmail.com>  
  
RUN apk add --no-cache uwsgi uwsgi-python  
  
COPY check_resultserver.py /check_resultserver.py  
  
COPY *.ini /etc/uwsgi/apps-enabled/  
COPY docker-entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

