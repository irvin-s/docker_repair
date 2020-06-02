FROM php:5-apache  
  
# Install libxslt, zlib and Git  
RUN apt-get update \  
&& apt-get install -y \  
git \  
libxslt1-dev \  
zlib1g-dev \  
&& apt-get clean \  
&& apt-get autoremove \  
&& rm -r /var/lib/apt/lists/*  
# enable mysqli, xsl and zlib PHP modules  
RUN docker-php-ext-install \  
mysqli \  
xsl \  
zip  
  
# enable mod_rewrite  
RUN a2enmod rewrite  
  
# Clone Symphony, it's submodules and the sample workspace  
RUN git clone git://github.com/symphonycms/symphony-2.git /var/www/html \  
&& git checkout --track origin/bundle \  
&& git submodule update --init --recursive \  
&& git clone git://github.com/symphonycms/workspace.git \  
&& chown -R www-data:www-data *  

