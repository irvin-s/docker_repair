# Version 1.0.0  
# cyan.team.Wiki  
#========== Basic Image ==========  
From dreaminsun/lamp  
MAINTAINER "DreamInSun"  
#========== Extension ==========  
RUN docker-php-ext-install pdo  
  
#========== Environment ==========  
ENV DOKUWIKI_ROOT $APACHE_DOC  
ENV BACKUP_DIR /backup  
  
#========== Configuration ==========  
#========== Install Application ==========  
ADD dokuwiki $APACHE_DOC  
  
#========== Expose Ports ==========  
#EXPOSE 8080  
#========== VOLUME ==========  
VOLUME /var/www/html/data  
VOLUME /backup  
  
#========= Add Entry Point ==========  
ADD shell /shell  
RUN chmod a+x /shell/*  
  
#========= Start Service ==========  
ENTRYPOINT ["/shell/docker-entrypoint.sh"]

