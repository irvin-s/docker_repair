FROM kibana:4.5  
MAINTAINER david@driveclutch.com  
  
RUN apt-get update && apt-get install -y netcat  
  
RUN gosu kibana kibana plugin --install elastic/sense  
RUN gosu kibana kibana plugin --install elastic/timelion  

