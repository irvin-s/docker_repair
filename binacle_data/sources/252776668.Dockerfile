FROM python:3  
ENV PYTHONUNBUFFERED 1  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
RUN mkdir /config  
  
ADD requirements.txt /config/  
RUN pip install -r /config/requirements.txt  
  
RUN mkdir /src;  
WORKDIR /src  

