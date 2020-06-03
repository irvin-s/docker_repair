FROM python:2.7-alpine  
  
RUN apk add --update --progress \  
musl \  
build-base \  
bash \  
git  
  
#ENV PYTHON_PIP_VERSION 8.1.0  
RUN pip install -q --no-cache-dir --upgrade pip  
  
RUN pip install twisted  
  
RUN mkdir /app/syncplay -p  
RUN git clone https://github.com/Syncplay/syncplay /app/syncplay  
  
EXPOSE 8999  
COPY ./entrypoint.sh /entrypoint.sh  
WORKDIR /app/syncplay  
ENTRYPOINT ["/entrypoint.sh"]  

