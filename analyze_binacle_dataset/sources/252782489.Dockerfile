FROM alpine:3.4  
MAINTAINER clement LE CORRE <clement@le-corre.eu>  
RUN apk --no-cache --update add \  
py-pip \  
python3  
  
RUN pip3 install --upgrade pip && \  
pip3 install bottle requests  
  
COPY web /web  
WORKDIR /web  
ENV DNS 8.8.8.8  
EXPOSE 80  
CMD ["python3", "/web/main.py"]  

