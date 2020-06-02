FROM postgres  
MAINTAINER butlerx <cian@coderdojo.org>  
RUN apt-get -y update && \  
apt-get -y install bash openssl python3-pip && \  
pip3 install awscli && \  
mkdir /scripts  
COPY backupToS3.sh /scripts/backupToS3.sh  
CMD ["bin/sh", "/scripts/backupToS3.sh"]  

