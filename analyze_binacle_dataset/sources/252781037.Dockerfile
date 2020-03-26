FROM docker.io/python:2-alpine3.7  
RUN apk add --no-cache --virtual build-base  
  
COPY . /sygnal  
  
WORKDIR /sygnal  
  
RUN mkdir var  
  
RUN pip install --upgrade pip \  
&& pip install gunicorn \  
&& pip install .  
  
RUN apk del --purge build-base  
  
COPY ./gunicorn_config.py.sample /sygnal/gunicorn_config.py  
COPY ./sygnal.conf.sample /sygnal/sygnal.conf  
  
EXPOSE 5000/tcp  
CMD ["gunicorn", "-c", "gunicorn_config.py", "sygnal:app"]

