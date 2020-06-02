FROM xeor/base-centos-daemon

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-12

# There is a Docker/centos7 bug that makes the httpd installation fail, but we are using nginx anyway, so that is why we are eating up the failed yum command..
RUN yum install -y zip unzip php php-fpm php-xml php-pdo php-mcrypt php-gd php-pear sqlite nginx || true && \
    pear config-set auto_discover 1 && pear channel-discover pear.amazonwebservices.com && \
    pear install -f HTTP_WebDAV_Client HTTP_OAuth aws/sdk Mail_mimeDecode && \
    curl -L http://sourceforge.net/projects/ajaxplorer/files/pydio/stable-channel/5.2.3/pydio-core-5.2.3.zip/download > pydio.zip && \
    unzip pydio.zip && mv pydio-core* pydio && \
    sed '/^listen = /clisten = 0.0.0.0:9000' -i /etc/php-fpm.d/www.conf && \
    sed '/^upload_max_filesize = /cupload_max_filesize = 1G' -i /etc/php.ini && \
    sed '/^post_max_size = /cpost_max_size = 1G' -i /etc/php.ini && \
    sed '/^output_buffering = /coutput_buffering = Off' -i /etc/php.ini && \
    chown -R apache: /pydio/data 
    
ADD nginx.conf /etc/nginx/conf.d/pydio.conf

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/

VOLUME ["/data"]
EXPOSE 8080
