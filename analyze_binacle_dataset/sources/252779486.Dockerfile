  
FROM caio2k/mer-n950:latest  
MAINTAINER caio2k  
  
WORKDIR /srv/mer/targets/n950rootfs/root  
RUN /root/./sb2_wrapper.exp 'zypper in perl ncurses-devel'  
  
VOLUME ["/input","/output"]  
COPY docker-entrypoint.sh /srv/mer/targets/n950rootfs/root/  
COPY prepare_modules.sh /srv/mer/targets/n950rootfs/root/  
RUN chmod +x /srv/mer/targets/n950rootfs/root/*.sh  
ENTRYPOINT ["/srv/mer/targets/n950rootfs/root/docker-entrypoint.sh"]  
  

