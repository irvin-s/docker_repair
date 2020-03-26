FROM python:3-alpine  
  
RUN apk add --no-cache gettext ca-certificates make bash && \  
update-ca-certificates && \  
pip install --no-cache-dir boto3 pyyaml && \  
mkdir -p /srv/app  
  
WORKDIR /srv/app  
  
ADD scripts /scripts  
  
CMD ["python3", "--version"]  

