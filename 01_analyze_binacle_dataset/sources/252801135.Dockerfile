# Version 1.0.0  
# cyan.img.Lamp  
#========== Basic Image ==========  
From centos:6.7  
MAINTAINER "DreamInSun"  
#========== Install EPEL & REMI ==========  
ADD rpm /rpm  
RUN rpm -Uvh /rpm/epel-release-6-8.noarch.rpm  
RUN rpm -Uvh /rpm/remi-release-6.rpm  
  
#========== Edit Config ==========  
ADD etc /etc  
  
#========== Install 389 DirSrv ==========  
RUN yum install -y 389-ds openldap-clients  
  
#========== Expose ==========  
EXPOSE 389  
#EXPOSE 636  
#EXPOSE 9830  
#========= Initialiaze Shell ==========  
ADD shell /shell  
RUN chmod a+x /shell/*  
  
#========== Entry Point ==========  
RUN /shell/docker-entrypoint.sh  
RUN cat /tmp/setup*.log  
#ENTRYPOINT ["/shell/docker-entrypoint.sh"]

