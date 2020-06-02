FROM convox/python  
  
RUN apt-get -y install libmysqld-dev libpq-dev libsqlite3-dev  
RUN apt-get -y install gunicorn3 nginx  
  
ENV PORT 8000  
  
COPY bin/web /app/bin/web  
COPY conf/nginx.conf /etc/nginx/nginx.conf  
  
CMD ["bin/web"]  

