FROM java:8-jre  
MAINTAINER duanmx duanmxcode@sina.com  
  
ENV APP_NAME atwork-serveplatform-bootstrap-2.0.0-GA  
ENV WORK_HOME /usr/serveplatform  
ENV CONFIG_NAME config.sh  
  
COPY . $WORK_HOME  
WORKDIR $WORK_HOME  
  
#RUN tar zxvf $APP_NAME.tar.gz  
RUN cp $WORK_HOME/$CONFIG_NAME $WORK_HOME/$APP_NAME/etc  
  
CMD ["/bin/bash","/usr/serveplatform/start.sh"]  
  

