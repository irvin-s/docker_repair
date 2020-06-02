FROM alpine:latest  
MAINTAINER William Weiskopf <william@weiskopf.me>  
  
RUN apk add \--no-cache \  
python3 \  
&& adduser -D -u 1000 monitor  
  
ADD monitor.py /monitor.py  
  
USER monitor  
  
# Needs environment variables for username, token, etc.  
  
ENTRYPOINT ["python3", "monitor.py"]  
  

