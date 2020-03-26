FROM dangermike64/automation-gradle  
  
RUN mkdir /tests  
ADD webservicetest /tests/  
  
WORKDIR "/tests/"  
  
RUN gradle testClasses  

