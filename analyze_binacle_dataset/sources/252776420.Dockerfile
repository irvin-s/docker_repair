FROM boomtownroi/data-volume:latest  
  
MAINTAINER BoomTown CNS Team <consumerteam@boomtownroi.com>  
  
ENV ALLOW_DEBUG true  
  
# Install nginx and have it forward logs to Docker  
RUN add-apt-repository -y ppa:nginx/stable &2> /dev/null  
  
RUN apt-get update && \  
apt-get install -y git php-fpm php-mysql php-curl php-gd \  
php-intl php-mbstring php-pear php-imagick php-imap php-mcrypt php-memcached \  
g++ cpp php-dev \  
php-pspell php-recode php-tidy php-xmlrpc php-xsl php-xdebug netcat \  
pkg-config byacc && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Install latest development version of Swig that has support for PHP7  
RUN cd / && \  
git clone https://github.com/swig/swig.git  
  
RUN cd swig && \  
sh ./autogen.sh && \  
./configure && \  
make && \  
make install  
  
# Clean up  
RUN cd / && \  
rm -rf swig  
  
# Install & configure the 51Degrees extension  
RUN cd / && \  
git clone https://github.com/51Degrees/Device-Detection.git  
  
RUN cd Device-Detection/php/pattern && \  
phpize && \  
./configure PHP7=1 && \  
make install  
  
# Clean up  
RUN cd / && \  
rm -rf Device-Detection && \  
apt-get remove -y git  
  
# COPY root/build-v8.sh /build-v8.sh  
# RUN /build-v8.sh  
COPY root /  
  
RUN phpenmod opcache && phpdismod xdebug  
  
VOLUME /var/run/fpm/  

