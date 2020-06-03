FROM alpine:latest  
  
RUN apk add --update \  
python \  
py-pip \  
&& rm -rf /var/cache/apk/* \  
&& pip install \  
boto \  
dnspython  
  
COPY r53dyndns.py /usr/local/bin/r53dyndns.py  
COPY run.sh /run.sh  
  
ENTRYPOINT ["/run.sh"]  

