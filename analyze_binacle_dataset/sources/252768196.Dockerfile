#FROM python:3-alpine  
FROM alpine:3.5  
RUN apk add --update \  
python \  
py-pip && \  
pip install ansible-tower-cli && \  
pip install --upgrade pip && \  
rm -rf /var/cache/apk/*  
  
CMD [ "tower-cli", "--version" ]

