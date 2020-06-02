FROM python:3.6  
  
RUN set -eux; \  
apt-get update -y ; \  
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
make \  
libicu-dev \  
rsync \  
; \  
apt-get clean ; \  
rm -rf /var/lib/apt/lists/* ; \  
:  
  
RUN set -eux ; \  
pip --no-cache-dir install \  
asyncpg \  
flake8 \  
pyicu \  
pytest \  
sanic \  
; \  
:  

