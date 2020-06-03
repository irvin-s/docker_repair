FROM lsiobase/alpine  
  
# For development.  
ARG PIP_INDEX_URL  
ARG PIP_TRUSTED_HOST  
  
RUN \  
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> \  
/etc/apk/repositories && \  
apk add --no-cache \  
python3 \  
py3-apsw \  
py3-requests \  
py3-yaml && \  
pip3 install --no-cache-dir -U btn  
  
COPY root/ /  
  
VOLUME /btn  

