FROM alpine:3.4  
MAINTAINER ashmastaflash  
  
RUN apk update && \  
apk add \  
python \  
py-pip  
  
RUN pip install \  
cloudpassage \  
github3.py  
  
COPY ./ /app/  
  
WORKDIR /app  
  
CMD python /app/runner.py  

