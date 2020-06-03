FROM python:3.6.5  
  
ENV TZ=Asia/Shanghai  
#RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi  
  
#COPY cmd.sh /  
#RUN chmod +x /cmd.sh  
  
COPY requirement.txt /requirement.txt  
#COPY pip.conf /root/.pip/pip.conf for mirror in China  
#COPY source.list /etc/apt/sources.list for mirror in China  
  
RUN pip install -r /requirement.txt  
#WORKDIR app  
#COPY app /app  
  
EXPOSE 5000  
#CMD ["/cmd.sh"]  
#CMD ["python", "/app/app.py"]  

