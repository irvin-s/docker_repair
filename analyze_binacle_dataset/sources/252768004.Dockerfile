FROM alpine:3.4  
MAINTAINER "Adam Dodman <adam.dodman@gmx.com>"  
RUN apk add --no-cache python3\  
&& pip3 install --upgrade pip \  
&& pip3 install ts3\  
&& mkdir /ts3selfserve  
  
ADD *.py /ts3selfserve  
  
VOLUME ["/config"]  
WORKDIR /ts3selfserve  
CMD ["python3","-u","/ts3selfserve/main.py","-c","/config"]  

