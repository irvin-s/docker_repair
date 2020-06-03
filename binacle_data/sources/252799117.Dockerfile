FROM dewiring/spec_base  
  
MAINTAINER Andreas Schmidt <andreas@de-wiring.net>  
  
ADD entrypoint.sh /entrypoint.sh  
ADD project_step_definitions /project_step_definitions  
  
ENTRYPOINT [ "/entrypoint.sh" ]  

