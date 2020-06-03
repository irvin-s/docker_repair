FROM davask/d-files  
MAINTAINER davask <contact@davaskweblimited.com>  
  
LABEL dwl.files.framework="symfony2"  
  
RUN apt-get update  
RUN apt-get install -y php5  
RUN apt-get install -y curl  
RUN apt-get install -y git  
RUN apt-get install -y acl  
RUN rm -rf /var/lib/apt/lists/*  
  
RUN curl -sS https://getcomposer.org/installer | php;  
RUN mv composer.phar /usr/local/bin/composer;  
  
# Declare instantiation counter  
ENV DWL_INIT_COUNT 2  
# Copy instantiation specific file  
COPY ./update-symfony.sh $DWL_INIT_DIR/$DWL_INIT_COUNT-update-symfony.sh  

