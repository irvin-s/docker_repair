FROM python:3.6-alpine  
  
COPY requirements.txt /app/  
  
RUN apk add --no-cache --virtual .build-deps \  
gcc libc-dev linux-headers && \  
pip install -r /app/requirements.txt && \  
apk del .build-deps  
  
RUN adduser -S uwsgi  
  
USER uwsgi  
  
COPY . /app  
  
WORKDIR /app  
  
EXPOSE 5000  
CMD uwsgi --http :5000 -w app:app --enable-threads --processes 10  

