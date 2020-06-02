FROM python:3.5.2-alpine  
  
RUN apk add --update \  
ca-certificates openssl \  
&& update-ca-certificates \  
&& rm -rf /var/cache/apk/*  
  
COPY requirements.txt /requirements.txt  
RUN pip install -r /requirements.txt  
  
WORKDIR /app  
COPY src/ ./  
  
CMD python app.py  

