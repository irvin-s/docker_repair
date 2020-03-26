FROM akuma12/storm:latest  
MAINTAINER akuma12  
  
RUN /usr/bin/config-supervisord.sh nimbus  
  
EXPOSE 6627  
EXPOSE 3772  
EXPOSE 3773  
ADD start-supervisor.sh /usr/bin/start-supervisor.sh  
CMD /usr/bin/start-supervisor.sh  

