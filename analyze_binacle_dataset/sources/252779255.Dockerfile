FROM python:3-alpine  
RUN apk update \  
&& apk add git gcc musl-dev linux-headers libxslt-dev libxml2-dev --no-cache \  
&& pip install streamlink bs4 lxml gevent \  
&& git clone https://github.com/bzsklb/ChaturbateRecorder /cr \  
&& apk del git gcc musl-dev --no-cache \  
&& rm -Rf /tmp/*  
CMD cd /cr && python ChaturbateRecorder.py  

