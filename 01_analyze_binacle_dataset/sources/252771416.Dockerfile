FROM python:alpine  
  
RUN apk update && apk add bash vim ethtool  
RUN pip install --upgrade pip  
RUN pip install pika  
CMD /bin/bash  

