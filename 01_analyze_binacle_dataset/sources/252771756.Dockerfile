FROM alpine  
RUN apk add \--update \--no-cache \  
python \  
py-pip \  
py-google-api-python-client \  
py-openssl \  
py-uritemplate \  
libffi-dev \  
py-cryptography \  
py-enum34 \  
py-cffi \  
py-lockfile  
  
RUN pip install --upgrade oauth2client==2.0.2

