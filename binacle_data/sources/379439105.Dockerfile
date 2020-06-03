FROM httpd:2.4.35-alpine
RUN apk update; apk upgrade;

# copy host apache config to proxy php requests to php-fpm container
COPY local.apache.conf /usr/local/apache2/conf/local.apache.conf
RUN echo "Include /usr/local/apache2/conf/local.apache.conf" >> /usr/local/apache2/conf/httpd.conf

# enable mod_rewrite
RUN sed -i '/LoadModule rewrite_module/s/^#//g' /usr/local/apache2/conf/httpd.conf && \
    sed -i 's#AllowOverride [Nn]one#AllowOverride All#' /usr/local/apache2/conf/httpd.conf

# generate certificates and enable SSL
# https://medium.freecodecamp.org/how-to-get-https-working-on-your-local-development-environment-in-5-minutes-7af615770eec
# https://docs.docker.com/ee/ucp/interlock/usage/tls/
# https://serverfault.com/a/870832
# https://medium.com/@nh3500/how-to-create-self-assigned-ssl-for-local-docker-based-lamp-dev-environment-on-macos-sierra-ab606a27ba8a
# https://github.com/InAnimaTe/docker-httpd-ssl/blob/master/Dockerfile
RUN apk add openssl
COPY gen-certs.sh /usr/local/apache2/conf/
RUN chmod +x /usr/local/apache2/conf/gen-certs.sh
RUN cd conf && ./gen-certs.sh && cd ..
RUN sed -i \
        -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
        -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
        -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
        conf/httpd.conf

RUN apk del openssl
