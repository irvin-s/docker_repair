FROM webdevops/php-nginx:7.2  
ENV TZ UTC  
  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \  
&& echo $TZ > /etc/timezone \  
&& dpkg-reconfigure -f noninteractive tzdata  
  
# PHP  
RUN apt-get update && apt-get install -y \  
openssh-client \  
wget \  
unzip \  
g++ \  
git \  
libssl-dev \  
libicu-dev \  
curl \  
libcurl4-openssl-dev \  
libmagickwand-dev --no-install-recommends \  
zlib1g-dev \  
libreadline-dev \  
libedit-dev \  
libz-dev \  
libmcrypt-dev \  
libreadline-dev  
  
RUN docker-php-ext-install intl  
RUN docker-php-ext-install json  
RUN docker-php-ext-install curl  
RUN docker-php-ext-enable curl  
RUN docker-php-ext-install opcache  
RUN docker-php-ext-install pdo  
RUN docker-php-ext-install pdo_mysql  
RUN docker-php-ext-install mbstring  
RUN docker-php-ext-install zip  
RUN docker-php-ext-install bcmath  
RUN docker-php-ext-install xml  
RUN docker-php-ext-install readline  
RUN docker-php-ext-install exif  
RUN docker-php-ext-install gd  
  
# Install nodejs and yarn  
RUN apt-get install --yes curl  
RUN curl --silent --location https://deb.nodesource.com/setup_9.x | bash -  
RUN apt-get install -y nodejs  
RUN apt-get install -y build-essential  
RUN npm install -g yarn  

