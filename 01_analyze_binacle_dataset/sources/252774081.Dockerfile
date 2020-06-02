FROM python:2-alpine  
  
EXPOSE 443  
  
COPY server /tmp/server  
RUN apk add \--no-cache --update openssl \  
&& which openssl \  
&& apk add openssl \  
&& pip install raven \  
&& pip install dnspython \  
&& pip install requests \  
&& pip install tld \  
&& mkdir /app/ \  
&& cp -R /tmp/server /app/scmt \  
&& mkdir -p /var/lib/scmt  
  
VOLUME ["/var/lib/scmt"]  
CMD ["python", "/app/scmt/run.py", "/var/lib/scmt/scmt.ini"]  

