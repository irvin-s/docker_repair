# Version 1.2.0  
# cyan.img.Tomcat  
#========== Basic Image ==========  
From tomcat:8.5.23-jre8  
MAINTAINER "DreamInSun"  
#========== Environment ==========  
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  
  
#========== Configuration ==========  
#ENV JAVA_OPTS_XMS 128M  
#ENV JAVA_OPTS_XMX 512M  
#ENV JAVA_OPTS_PERM_SIZE 64M  
#ENV JAVA_OPTS_PERM_SIZE_MAX 128M  
ENV SERVICE_VERSION LTS  
ENV PROFILE product  
  
#========== System Optimization ==========  
RUN ulimit -HSn 4096  
  
#========== Install Application ==========  
ENV CATALINA_HOME /usr/local/tomcat  
ADD tomcat $CATALINA_HOME  
RUN chmod a+x $CATALINA_HOME/bin/catalina.sh  
RUN rm -rf $CATALINA_HOME/webapps/docs  
RUN rm -rf $CATALINA_HOME/webapps/examples  
  
#========== Expose Ports ==========  
#EXPOSE 8080  
#========= Add Entry Point ==========  
ADD shell /shell  
RUN chmod a+x /shell/*  
  
#========= Start Service ==========  
ENTRYPOINT ["/shell/docker-entrypoint.sh"]

