FROM tvial/docker-mailserver:2.1  
  
RUN export PATH_CHMOD=$(which chmod) \  
export PATH_CHOWN=$(which chown) \  
export PATH_TRUE=$(which true) \  
cp $PATH_TRUE $PATH_CHMOD && \  
cp $PATH_TRUE $PATH_CHOWN  

