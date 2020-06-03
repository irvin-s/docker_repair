FROM bruceadams/wdscli  
MAINTAINER Bruce Adams <ba@us.ibm.com>  
  
RUN apk add --no-cache openjdk8-jre  
ADD https://ibm.biz/kale-jar /usr/local/lib/kale.jar  
RUN chmod a+r /usr/local/lib/kale.jar  
COPY kale.sh /usr/local/bin/kale  

