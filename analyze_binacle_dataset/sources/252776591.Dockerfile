FROM python:2-alpine  
  
# 作成者情報  
MAINTAINER toshi <toshi@toshi.click>  
  
RUN apk --update add curl && \  
rm -rf /var/cache/apk/*  
  
RUN pip install yamllint  

