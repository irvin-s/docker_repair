FROM qqiangwu/reins-eis:jboss  
  
COPY start.sh /  
RUN chmod +x /start.sh  
  
COPY standalone.xml /jboss-eap-6.4/standalone/configuration  
  

