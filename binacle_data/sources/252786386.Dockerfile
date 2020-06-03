FROM dockenizer/alpine  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add openssh git perl sudo && \  
addgroup git && \  
adduser git -G git -S -D -s /bin/bash && \  
passwd -d git && \  
rm -rf /var/cache/apk/*  
  
COPY run.sh /run.sh  
RUN chmod +x /run.sh  
  
EXPOSE 22  
CMD /run.sh

