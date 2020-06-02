# DOCKER-VERSION 1.0.1
FROM ggotti/aem-base
MAINTAINER ggotti

# Install Apache
RUN yum install -y --enablerepo=centosplus libselinux-devel
RUN yum install -y --enablerepo=centosplus httpd
RUN yum install -y tar 

# Download the Dispatcher
RUN wget https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher/_jcr_content/top/download_28/file.res/dispatcher-apache2.2-linux-x86-64-ssl10-4.1.8.tar.gz
RUN mkdir mkdir -p dispatcher
RUN tar -C dispatcher -zxvf dispatcher-apache2.2-linux-x86-64-ssl10-4.1.8.tar.gz
RUN ls ./dispatcher

# Copy Dispatcher
RUN cp "./dispatcher/dispatcher-apache2.2-4.1.8.so" "/etc/httpd/modules/dispatcher-apache2.2-4.1.8.so"
RUN ln -s /etc/httpd/modules/dispatcher-apache2.2-4.1.8.so /etc/httpd/modules/mod_dispatcher.so

# Add config files
ADD https://raw.githubusercontent.com/ggotti/aem-dispatcher/master/httpd.conf /etc/httpd/conf/httpd.conf
ADD https://raw.githubusercontent.com/ggotti/aem-dispatcher/master/dispatcher.any /etc/httpd/conf/dispatcher.any

CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]

EXPOSE 80 443
