FROM python:3.6  
RUN mkdir /app  
COPY . /app  
  
RUN mkdir /usr/src/sock  
  
RUN pip install uwsgi  
RUN pip install -r /app/requirements.txt  
RUN pip install git+https://gitee.com/hahasystem/py_aliyun_log.git  
RUN pip install -U aliyun-log-python-sdk  

