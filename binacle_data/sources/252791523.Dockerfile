FROM python:3.4  
  
# -r is system group/user  
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi  
  
RUN pip install Flask==0.10.0 uWSGI==2.0.8 requests==2.5.1 redis==2.10.3  
WORKDIR /app  
COPY app /app  
COPY entrypoint.sh /  
RUN chmod +x /entrypoint.sh  
  
EXPOSE 9090 9191  
  
# Run as user uwsgi, not as root  
USER uwsgi  
  
CMD ["/entrypoint.sh"]  

