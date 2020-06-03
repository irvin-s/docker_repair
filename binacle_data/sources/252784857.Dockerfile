FROM williamyeh/ansible:alpine3  
  
RUN apk --no-cache add --virtual build-dependencies \  
openssl \  
libc-dev \  
python-dev \  
gcc \  
&& pip install \  
apache-libcloud \  
pycrypto \  
&& apk del build-dependencies  

