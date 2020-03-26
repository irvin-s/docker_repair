FROM alpine:3.6  
RUN apk --update add --no-cache postgresql  
RUN apk --update add --no-cache postgresql-client  
RUN apk --update add --no-cache bash py-pip py-setuptools ca-certificates  
  
RUN pip install s3cmd==2.0.0  
  
COPY backup.sh .  
  
CMD ["backup.sh"]  

