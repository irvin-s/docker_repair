# Build Custom Docker Image from official cloudera/quickstart image  
# To be used as data container for Continuous Integration and testing  
# at ODS project  
  
FROM digitalknowledge/ods-cloudera  
  
MAINTAINER digitalknowledge admin@digital-knowledge.es  
  
### Create required data folder  
RUN mkdir -p /tmp/ods_data_files  

