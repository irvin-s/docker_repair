FROM dispel4py/storm:0.10.0  
MAINTAINER dispel4py  
RUN /usr/bin/config-supervisord.sh ui  
  
EXPOSE 8080  
CMD /usr/bin/start-supervisor.sh  
  

