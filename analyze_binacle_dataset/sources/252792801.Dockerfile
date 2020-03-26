FROM spotify/docker-gc  
  
MAINTAINER Jonathan Baker <chessracer@gmail.com>  
  
COPY root.cron /var/spool/cron/crontabs/root  
COPY exclude_containers_list /exclude_containers_list  
COPY exclude_images_list /exclude_images_list  
  
VOLUME /var/spool/cron  
  
CMD ["crond", "-f", "-d", "8"]  

