FROM after4u/alpine-base:latest  
  
MAINTAINER Ken Huang <ken@after4u.com>  
RUN apk --update add supervisor  
  
RUN rm -rf /var/cache/apk/*  
  
WORKDIR /projects  
  
COPY run.sh /run.sh  
RUN chmod 755 /*.sh  
  
COPY etc/supervisord.conf /etc/supervisord.conf  
  
ENTRYPOINT ["/run.sh"]

