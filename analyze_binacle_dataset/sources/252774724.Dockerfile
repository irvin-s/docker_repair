FROM alpine  
MAINTAINER Jon Brisbin <jbrisbin@basho.com>  
  
RUN apk add --update python py-pip  
COPY requirements.txt /tmp/requirements.txt  
RUN \  
pip install -r /tmp/requirements.txt && \  
rm -f /tmp/requirements.txt  
  
COPY generate-json.py /usr/sbin/generate-json  
RUN chmod a+x /usr/sbin/generate-json  
  
WORKDIR /root  
  
ENTRYPOINT ["/usr/sbin/generate-json"]  

