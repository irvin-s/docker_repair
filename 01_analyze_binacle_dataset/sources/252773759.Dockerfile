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
py3-yaml \  
fuse \  
libattr \  
pkgconfig && \  
apk add --no-cache --virtual=build-dependencies \  
gcc \  
musl-dev \  
python3-dev \  
attr-dev \  
fuse-dev && \  
pip3 install --no-cache-dir -U cython && \  
pip3 install --no-cache-dir -U yatfs && \  
pip3 uninstall -y cython && \  
apk del --purge build-dependencies && \  
rm -rf /var/cache/apk/*  
  
COPY root/ /  
  
VOLUME /mnt /btn /deluge  
  
HEALTHCHECK --interval=10s \--timeout=10s CMD /healthcheck.sh || exit 1  

