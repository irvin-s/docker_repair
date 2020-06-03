FROM debian:jessie  
MAINTAINER mail@danny-edel.de  
  
COPY sources-pre.list /etc/apt/sources.list  
COPY debconf-preseed /tmp/  
  
RUN DEBIAN_FRONTEND=noninteractive \  
&& debconf-set-selections /tmp/debconf-preseed \  
&& apt-get update \  
&& apt-get -y install apt-utils \  
&& apt-get -y dist-upgrade \  
&& apt-get -y install \  
apt-cacher-ng/jessie-backports \  
supervisor \  
cron unattended-upgrades ssmtp apt-listchanges \  
&& apt-get clean \  
&& apt-get -y autoclean \  
&& apt-get -y autoremove \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /tmp/*  
  
COPY backends_debian backends_ubuntu backends_raspbian \  
/etc/apt-cacher-ng/  
  
COPY sources-post.list /etc/apt/sources.list  
  
COPY supervisord.conf /etc/supervisor/conf.d/  
  
COPY zzz_override.conf /etc/apt-cacher-ng/  
  
EXPOSE 3142  
ENTRYPOINT [ "/usr/bin/supervisord" ]  
  
VOLUME [ "/var/cache/apt-cacher-ng" ]  

