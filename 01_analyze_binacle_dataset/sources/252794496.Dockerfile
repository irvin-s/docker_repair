FROM datafairifier/ctp-baseimage  
  
# The base image has set the INSTALL_HOME environment variable  
COPY config.xml $INSTALL_HOME/CTP/  
  
COPY scripts/* $INSTALL_HOME/CTP/scripts/CAT/  
  
EXPOSE 104

