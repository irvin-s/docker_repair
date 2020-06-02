FROM davask/d-base:latest  
MAINTAINER davask <contact@davaskweblimited.com>  
  
LABEL dwl.files.language="php5"  
  
# define dir app within user folder  
ENV DWL_APP_DIR files  
  
# Declare instantiation type  
ENV DWL_INIT files  
# Declare instantiation counter  
ENV DWL_INIT_COUNT 1  
# Declare instantiation dir  
ENV DWL_INIT_DIR /tmp/dwl-$DWL_INIT  
  
# Copy instantiation specific file  
COPY ./files.sh $DWL_INIT_DIR/$DWL_INIT_COUNT-files.sh  

