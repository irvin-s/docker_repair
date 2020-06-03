FROM docker:17.07-git  
  
# install fabric  
RUN set -eux; \  
apk add --no-cache \  
make \  
gcc \  
py-pip \  
python-dev \  
musl-dev \  
libffi-dev \  
openssl-dev \  
; \  
pip install \  
docker-compose \  
fabric; \  
docker-compose version; \  
fab --version  

