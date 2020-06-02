FROM alpine:3.4  
MAINTAINER toolbox@cloudpassage.com  
  
  
  
RUN apk add -U \  
gettext=0.19.7-r3 \  
python=2.7.12-r0 \  
py-pip=8.1.2-r0  
  
RUN apk add filebeat=1.3.1-r0 \  
\--update-cache \  
\--repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/  
  
RUN pip install cloudpassage==1.0.1  
  
COPY app/ /app  
  
CMD app/runner.sh  

