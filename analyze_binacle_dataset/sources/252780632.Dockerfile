FROM python:3.4  
  
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi  
RUN pip install requests==2.5.1 Flask==0.10.1 uWSGI==2.0.8 redis==2.10.3  
WORKDIR /app  
COPY app /app  
COPY cmd.sh /  
  
EXPOSE 9090 9191  
USER uwsgi  
  
CMD ["/cmd.sh"]  
  
  
  

