FROM httpd:2.4-alpine

# Install Apache requirements
RUN apk add --no-cache --virtual .persistent-deps openssl

# Install custom Apache configuration
COPY vhosts /usr/local/apache2/conf/extra/vhosts
RUN \
    perl -pi -e "s|#ServerName www.example.com:80|ServerName localhost:80|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule http2_module modules/mod_http2.so|LoadModule http2_module modules/mod_http2.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule proxy_module modules/mod_proxy.so|LoadModule proxy_module modules/mod_proxy.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule rewrite_module modules/mod_rewrite.so|LoadModule rewrite_module modules/mod_rewrite.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so|LoadModule socache_shmcb_module modules/mod_socache_shmcb.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#LoadModule ssl_module modules/mod_ssl.so|LoadModule ssl_module modules/mod_ssl.so|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|/usr/local/apache2/htdocs|/var/www/html|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#Include conf/extra/httpd-ssl.conf|Include conf/extra/httpd-ssl.conf|g" /usr/local/apache2/conf/httpd.conf && \
    perl -pi -e "s|#Include conf/extra/httpd-vhosts.conf|Include conf/extra/vhosts/*.conf|g" /usr/local/apache2/conf/httpd.conf

# Generate self-signed SSL certificate
RUN \
    mkdir -p /etc/ssl/private/ /etc/ssl/certs/ && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /usr/local/apache2/conf/server.key \
        -out /usr/local/apache2/conf/server.crt \
        -subj "/CN=localhost"

WORKDIR /var/www/html
