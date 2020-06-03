FROM node:6.11  
ENV GIT_URL ""  
ENV GIT_CHECKOUT "master"  
ENV NPM_INSTALL_COMMAND "install"  
ENV NPM_RUN_COMMAND "start"  
ADD startup.sh /usr/bin/startup.sh  
  
CMD ["/usr/bin/startup.sh"]  

