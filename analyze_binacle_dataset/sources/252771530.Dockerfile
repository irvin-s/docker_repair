FROM akel/lnmp-base:latest  
MAINTAINER Akel <akelmaister@outlook.com>  
  
RUN yum -y install memcached php-memcache php-mbstring  
  
## clean iptablse  
RUN rm -f /etc/sysconfig/iptables  
  
## Copy tamplates and scripts from repo.  
COPY template/nginx.conf_base /root/nginx.conf_base  
COPY scripts/initial.sh /root/initial.sh  
COPY scripts/entrypoint.sh /root/entrypoint.sh  
  
## Add execute permission's to scripts  
RUN chmod +x /root/initial.sh  
RUN chmod +x /root/entrypoint.sh  
  
ENTRYPOINT ["/root/entrypoint.sh"]  
  
EXPOSE 22 80 443  

