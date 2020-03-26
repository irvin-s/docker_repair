FROM java:8-jre  
MAINTAINER duanmx duanmxcode@sina.com  
  
ENV APP_NAME atwork-appmarket-bootstrap-2.0.0-GA2015092906  
ENV WORK_HOME /usr/appmark  
ENV CONFIG_NAME config.sh  
  
COPY . $WORK_HOME  
WORKDIR $WORK_HOME  
  
#RUN tar zxvf $APP_NAME.tar.gz  
RUN cp $WORK_HOME/$CONFIG_NAME $WORK_HOME/$APP_NAME/etc  
  
CMD ["/bin/bash","/usr/appmark/start.sh"]  
  

