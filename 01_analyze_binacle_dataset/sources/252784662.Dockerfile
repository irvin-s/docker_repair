FROM blackpill/php  
  
ENV WWWROOT /wwwroot  
ENV NFS_SERVER 10.171.76.236  
ENV NFS_DIR /wwwroot  
  
ADD sources.list /etc/apt/sources.list  
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
RUN apt-get update && apt-get install -y \  
subversion \  
wget \  
nodejs \  
openssh-server \  
ant \  
libxslt-dev \  
&& rm -r /var/lib/apt/lists/*  
  
# install gulp  
RUN npm install -g gulp  
  
# install phpdox  
ADD phpdox-0.9.0.phar /usr/bin/phpdox  
RUN chmod 755 /usr/bin/phpdox  
ADD xsl.so /usr/local/lib/php/extensions/no-debug-non-zts-20131226/xsl.so  
ADD ext-xsl.ini /usr/local/etc/php/conf.d/ext-xsl.ini  
  
# install phploc  
ADD phploc-3.0.1.phar /usr/bin/phploc  
RUN chmod 755 /usr/bin/phploc  
  
# install phpcb  
ADD phpcb-1.1.1.phar /usr/bin/phpcb  
RUN chmod 755 /usr/bin/phpcb  
  
# install phpunit  
ADD phpunit-5.4.6.phar /usr/bin/phpunit  
RUN chmod +x /usr/bin/phpunit  
  
#SSH service  
RUN useradd -m -d /home/dev dev  
RUN echo 'dev:testdev' | chpasswd  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
EXPOSE 22  
VOLUME ["/wwwroot"]  

