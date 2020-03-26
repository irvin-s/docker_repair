FROM baffledbear/nginx  
MAINTAINER Peter Rauhut <baffling.bear@gmail.com>  
  
RUN pip install uwsgi  
  
COPY nginx.conf /etc/nginx/conf.d  
COPY uwsgi.ini /etc/uwsgi/  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY ./app /app  
WORKDIR /app  
  
CMD ["/usr/bin/supervisord"]  

