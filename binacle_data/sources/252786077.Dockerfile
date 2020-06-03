FROM python:2.7-alpine  
  
COPY requirements.txt /usr/src/k2sbridge/  
  
RUN cd /usr/src/k2sbridge && \  
pip install -r requirements.txt  
  
COPY . /usr/src/k2sbridge/  
  
ENV PYTHONUNBUFFERED=1  
CMD /usr/src/k2sbridge/k2sbridge  

