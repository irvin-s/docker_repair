FROM python:3-alpine  
MAINTAINER He Bai <bai.he@outlook.com>  
  
RUN apk add --no-cache --virtual .build-deps \  
bzip2-dev \  
coreutils \  
dpkg-dev dpkg \  
expat-dev \  
gcc \  
g++ \  
gdbm-dev \  
libc-dev \  
libffi-dev \  
linux-headers \  
make \  
ncurses-dev \  
openssl \  
libressl-dev \  
pax-utils \  
readline-dev \  
sqlite-dev \  
tcl-dev \  
tk \  
tk-dev \  
xz-dev \  
zlib-dev \  
&& apk add --no-cache postgresql-dev \  
&& apk add --no-cache mariadb-dev \  
&& apk add --no-cache subversion \  
&& pip install --upgrade pip \  
&& pip --no-cache-dir install pandas==0.20.3 \  
&& pip --no-cache-dir install parade==0.1.20.7 \  
&& apk del .build-deps  
#RUN pip3 --no-cache-dir install beautifulsoup4  
  
EXPOSE 5000  
  
VOLUME /workspace  
WORKDIR /workspace  
  
#ENTRYPOINT parade  
#CMD server  

