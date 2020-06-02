FROM python:alpine  
  
RUN apk add --update-cache tzdata \  
&& pip install awscli \  
&& rm -fR /etc/periodic \  
&& rm -rf /var/cache/apk/*  
  
COPY backup /usr/local/bin/  
RUN chmod +x /usr/local/bin/backup  
  
COPY entrypoint.sh /sbin/entrypoint.sh  
RUN chmod +x /sbin/entrypoint.sh  
  
CMD ["/sbin/entrypoint.sh"]  

