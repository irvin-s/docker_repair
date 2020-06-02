FROM redpointgames/phabricator:latest  
ENV REFRESHED_AT 2017_04_27  
  
ADD addSprintPlugin.sh /addSprintPlugin.sh  
RUN su PHABRICATOR -c '/bin/bash /addSprintPlugin.sh'  
  
WORKDIR /  
CMD ["/init"]  

