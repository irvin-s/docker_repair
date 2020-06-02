FROM php:7.1  
  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer \  
&& chmod +x /usr/local/bin/composer  
  
RUN apt-get update && apt-get install -y \  
git \  
patch \  
unzip \  
zip \  
libzip-dev \  
python \  
python-dev  
  
RUN docker-php-ext-install bcmath \  
&& docker-php-ext-install zip  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/*  
  
RUN curl -o get-pip.py https://bootstrap.pypa.io/get-pip.py \  
&& python get-pip.py \  
&& pip install boto3==1.3.0  

