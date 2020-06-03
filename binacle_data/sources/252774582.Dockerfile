FROM python:3.6.2-jessie  
  
ENV TZ=Asia/Shanghai  
  
COPY app.py /app.py  
COPY requirement.txt /requirement.txt  
# COPY pip.conf /root/.pip/pip.conf # only for mirror in China  
# COPY source.list /etc/apt/sources.list # only for mirror in China  
RUN pip install -r /requirement.txt  
  
EXPOSE 2017  
CMD ["python", "app.py"]  

