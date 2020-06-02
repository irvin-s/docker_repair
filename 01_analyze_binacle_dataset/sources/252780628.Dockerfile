FROM copex/php  
  
# Build packages first  
RUN export DEBIAN_FRONTEND=noninteractive && \  
echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup && \  
apt-get update && \  
apt-get \--no-install-recommends -y --force-yes install \  
php5-fpm  
  
# Cleanup  
RUN apt-get clean && \  
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup && \  
find /var/lib/apt/lists -mindepth 1 -delete -print && \  
find /tmp /var/tmp -mindepth 2 -delete && \  
apt-get purge -y --auto-remove  
# Copy php config  
COPY php-fpm.conf /etc/php5/fpm/pool.d/www.conf  
  
EXPOSE 9000  
  
CMD ["php-fpm"]

