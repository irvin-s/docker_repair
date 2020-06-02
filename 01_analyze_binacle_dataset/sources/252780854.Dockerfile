FROM baffledbear/uwsgi  
MAINTAINER Peter Rauhut <baffling.bear@gmail.com>  
  
# Install uWSGI and Flask  
RUN pip install flask  
  
# Copy required files  
COPY nginx.conf /etc/nginx/conf.d/  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY uwsgi.ini /etc/uwsgi/  
COPY ./app /app  
WORKDIR /app  

