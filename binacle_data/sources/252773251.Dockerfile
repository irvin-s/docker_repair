FROM alpine:3.6  
LABEL maintainer="Benson Tucker <bensontucker@gmail.com>"  
  
RUN apk update && \  
apk add --no-cache bash git python3 postgresql-client py3-psycopg2 && \  
python3 -m ensurepip && \  
rm -r /usr/lib/python*/ensurepip && \  
pip3 install --upgrade pip setuptools && \  
if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \  
rm -r /root/.cache  

