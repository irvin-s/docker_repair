FROM python:3.4  
  
RUN apt-get update  
RUN apt-get -y upgrade  
COPY requirements.txt /  
RUN pip install -r requirements.txt  
WORKDIR /app  
COPY app /app  
COPY cmd.sh /  
RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi  
EXPOSE 9090 9191  
  
USER uwsgi  
  
CMD ["/cmd.sh"]  

