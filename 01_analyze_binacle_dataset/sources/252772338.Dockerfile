FROM alpine  
  
MAINTAINER Angelo Veltens <angelo.veltens@online.de>  
  
RUN apk add --no-cache docker python py-pip  
RUN pip install docker && pip install testinfra  
  
WORKDIR /project  
  
CMD pytest --verbose  

