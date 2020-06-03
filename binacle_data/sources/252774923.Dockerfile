FROM debian:jessie  
MAINTAINER Benjamin Böhmke <benjamin@boehmke.net>  
  
# update system and get packages  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y munin && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# prepare munin  
RUN mkdir /var/run/munin && \  
chmod 777 /var/run/munin && \  
mv /etc/munin/munin.conf /etc/munin/munin.conf.bak && \  
cp /etc/cron.d/munin /tmp/munin && \  
find /etc/cron.* -type f -delete && \  
mv /tmp/munin /etc/cron.d/munin  
  
# copy config and entrypoint  
COPY munin.conf /etc/munin/munin.conf  
COPY entrypoint.sh /opt/entrypoint  
  
# set volumes  
VOLUME ["/munin"]  
  
# set start command  
CMD ["/opt/entrypoint"]  
  

