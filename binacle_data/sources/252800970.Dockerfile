FROM debian:stretch  
MAINTAINER David Personette <dperson@gmail.com>  
  
RUN export DEBIAN_FRONTEND='noninteractive' && \  
export url='https://download.owncloud.org/community' && \  
export version='10.0.6' && \  
export sha256sum='de5153f059a7cecf5f191de053ff3ab4dea21ffba2b3ef207309' && \  
apt-get update -qq && \  
apt-get install -qqy --no-install-recommends bzip2 ca-certificates curl \  
openssl smbclient php7.0-bz2 php7.0-curl php7.0-fpm php7.0-gd \  
php7.0-gmp php7.0-imap php7.0-intl php7.0-json php7.0-ldap \  
php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-opcache \  
php7.0-pgsql php7.0-sqlite3 php7.0-xml php7.0-zip php-apcu-bc \  
php-imagick php-memcached php-redis procps \  
$(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\  
file="owncloud-${version}.tar.bz2" && \  
echo "downloading $file ..." && \  
curl -LOSs https://github.com/dperson/owncloud/raw/master/nginx.conf && \  
curl -LOSs ${url}/$file && \  
sha256sum $file | grep -q "$sha256sum" || \  
{ echo "expected $sha256sum, got $(sha256sum $file)"; exit 13; } && \  
file=/etc/php/7.0/fpm/php-fpm.conf && \  
sed -i 's|^;*\(daemonize\) *=.*|\1 = no|' $file && \  
sed -i 's|^;*\(error_log\) *=.*|\1 = /proc/self/fd/2|' $file && \  
file=/etc/php/7.0/fpm/pool.d/www.conf && \  
sed -i 's|^;*\(access_log\) *=.*|\1 = /proc/self/fd/2|' $file && \  
sed -i 's|^;*\(/catch_workers_output *=.*\)|\1|' $file && \  
sed -i 's|^;*\(chdir\) *=.*|\1 = /srv/www|' $file && \  
sed -i 's|^;*\(/clear_env *=.*\)|\1|' $file && \  
sed -i 's|^;*\(listen\) *=.*|\1 = [::]:9000|' $file && \  
unset file && \  
for i in /etc/php/7.0/*/php.ini; do \  
sed -i 's|^;*\(doc_root\) *=.*|\1 = "/srv/www"|' $i; \  
sed -i '/php_errors/s|^;*\(error_log\) *=.*|\1 = /proc/self/fd/2|' $i; \  
sed -i 's|^;*\(expose_php\) *=.*|\1 = On|' $i; \  
sed -i 's|^;*\(max_execution_time\) *=.*|\1 = 3600|' $i; \  
sed -i 's|^;*\(max_input_time\) *=.*|\1 = 3600|' $i; \  
sed -i 's|^;*\(opcache.enable\) *=.*|\1 = 1|' $i; \  
sed -i 's|^;*\(opcache.enable_cli\) *=.*|\1 = 1|' $i; \  
sed -i 's|^;*\(opcache.fast_shutdown\) *=.*|\1 = 1|' $i; \  
sed -i 's|^;*\(opcache.interned_strings_buffer\) *=.*|\1 = 8|' $i; \  
sed -i 's|^;*\(opcache.max_accelerated_files\) *=.*|\1 = 4000|' $i; \  
sed -i 's|^;*\(opcache.memory_consumption\) *=.*|\1 = 128|' $i; \  
sed -i 's|^;*\(opcache.revalidate_freq\) *=.*|\1 = 60|' $i; \  
sed -i 's|^;*\(output_buffering\) *=.*|\1 = 0|' $i; \  
sed -i 's|^;*\(post_max_size\) *=.*|\1 = 16G|' $i; \  
sed -i 's|^;*\(upload_max_filesize\) *=.*|\1 = 16G|' $i; \  
done && \  
echo '\n[apc]\napc.enable_cli = 1' >>/etc/php/7.0/mods-available/apcu.ini&&\  
apt-get purge -qqy ca-certificates curl && \  
apt-get autoremove -qqy && apt-get clean && \  
ln -s /srv/www /var/ && \  
mkdir -p /run/php && \  
rm -rf /var/lib/apt/lists/* /tmp/* $file  
COPY owncloud.sh /usr/bin/  
  
VOLUME ["/srv/www/owncloud"]  
  
EXPOSE 9000  
  
ENTRYPOINT ["owncloud.sh"]

