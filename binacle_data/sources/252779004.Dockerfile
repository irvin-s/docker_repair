FROM businessdecision/itkg:apache2.4-php5.6  
RUN systemMods=" \  
make \  
g++ \  
gcc \  
libcurl4-openssl-dev \  
libsasl2-2 \  
libsasl2-dev \  
libcurl3 \  
libav-tools \  
" \  
&& apt-get update && apt-get install -y $systemMods  
  
RUN pecl install mongo \  
&& pecl install igbinary  
  
RUN echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini \  
&& ln -s /etc/php5/mods-available/mongo.ini /etc/php5/cli/conf.d/30-mongo.ini  
  
RUN wget http://nodejs.org/dist/v0.10.24/node-v0.10.24.tar.gz \  
&& tar -xvzf node-v0.10.24.tar.gz \  
&& cd node-v0.10.24 \  
&& ./configure --prefix=/usr/local/ && make && make install  
  
CMD ["/run.sh"]  

