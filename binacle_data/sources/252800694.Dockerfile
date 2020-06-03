FROM sameersbn/redmine:3.1.1  
MAINTAINER Thomas Rambrant thomas@doorway.se  
  
RUN apt-get update && \  
apt-get install -y pandoc  
  
VOLUME ["/home/redmine/redmine/public/system/rich"]  

