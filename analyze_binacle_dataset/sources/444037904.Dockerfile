FROM xeor/base-centos-daemon

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-25

# There is a Docker/centos7 bug that makes the httpd installation fail, but we are using nginx anyway, so that is why we are eating up the failed yum command..
RUN yum localinstall -y http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    yum install -y tar zip unzip php php-fpm php-gd nginx ffmpeg ImageMagick || true && \
    curl -L http://release.larsjung.de/h5ai/h5ai-0.26.1.zip > h5ai.zip && \
    unzip h5ai.zip  -d /app && chown apache /app/_h5ai/cache && \
    sed '/^listen = /clisten = /php.sock' -i /etc/php-fpm.d/www.conf 
#    sed '/$this->root_abs_path = 
    
ADD nginx.conf /etc/nginx/conf.d/h5ai.conf
COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/

VOLUME ["/data"]
EXPOSE 8080
