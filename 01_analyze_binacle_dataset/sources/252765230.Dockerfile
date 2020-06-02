FROM 007backups/base:2.0  
  
LABEL company="007 Backups" \  
description="Borg Backup image" \  
version="1.0.10" \  
maintainer="info@007backups.com"  
  
  
ENV PYTHONUNBUFFERED 1  
ENV PYTHON_BORGBACKUP_VERSION 1.0.10  
  
  
RUN set -ex \  
&& apk add --upgrade --no-cache --virtual .build-pkgs \  
build-base \  
libressl-dev \  
acl-dev \  
lz4-dev \  
fuse-dev \  
musl-dev \  
pkgconf \  
&& apk add --upgrade --no-cache \  
libressl2.5-libcrypto \  
libacl \  
lz4-libs \  
fuse \  
musl \  
&& python3 -m pip install --no-cache-dir --upgrade \  
"borgbackup==$PYTHON_BORGBACKUP_VERSION" \  
&& apk del .build-pkgs  
  
  
CMD ["borg"]  

