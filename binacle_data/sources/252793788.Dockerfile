FROM alpine:3.5  
MAINTAINER dariko <git@dariozanzico.com>  
  
ENV OPENLDAP_ALPINE_VERSION 2.4.44-r3  
RUN apk --no-cache --update --update --no-cache add \  
openldap=$OPENLDAP_ALPINE_VERSION \  
openldap-clients=$OPENLDAP_ALPINE_VERSION  
  
RUN mkdir /etc/openldap/slapd.d/  
RUN mkdir /var/openldap  
VOLUME /etc/openldap/slapd.d/  
VOLUME /var/openldap  
  
ADD run.sh /run.sh  
ADD init_config.sh /init_config.sh  
RUN chmod +x /run.sh  
RUN chmod +x /init_config.sh  
  
CMD /run.sh  
  
EXPOSE 389  
EXPOSE 636  

