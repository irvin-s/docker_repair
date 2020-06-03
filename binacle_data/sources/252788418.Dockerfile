FROM python:alpine  
  
RUN apk --update add bash curl jq  
RUN pip install awscli  
RUN pip install boto3  
  
COPY entrypoint.sh /usr/bin/entrypoint.sh  
COPY register-host.py /usr/bin/register-host.py  
  
ENTRYPOINT ["/usr/bin/entrypoint.sh"]  
  
CMD ["/usr/bin/register-host.py"]

