  
FROM alpine:3.4  
RUN apk add -U \  
python \  
bash \  
curl \  
py-pip \  
gcc \  
python-dev \  
libxml2-dev \  
musl-dev \  
libxslt-dev  
RUN pip install pyquery==1.2.13  
  
COPY run.sh /run.sh  
COPY report.py /report.py  
  
ENTRYPOINT ["bash", "/run.sh"]  

