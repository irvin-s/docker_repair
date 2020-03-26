FROM php:7-cli  
  
#  
# requirements for magento/n98-magerun  
#  
  
RUN apt-get update && apt-get install -y \  
bzip2 \  
ca-certificates \  
curl \  
git \  
openssh-client \  
libcurl4-openssl-dev \  
libfreetype6-dev \  
libicu-dev \  
libjpeg-dev \  
libmcrypt-dev \  
libpng12-dev \  
libxml2-dev \  
libxslt1-dev \  
&& rm -rf /var/lib/apt/lists/*  

