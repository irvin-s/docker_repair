FROM alpine:3.7  
  
RUN apk add --no-cache \  
gcc \  
libssl1.0 \  
libcurl \  
g++ \  
tar \  
libzip-dev \  
wget \  
curl \  
libcurl \  
make \  
curl-dev \  
mariadb-dev  

