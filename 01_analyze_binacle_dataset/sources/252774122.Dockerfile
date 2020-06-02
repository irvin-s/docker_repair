FROM alpine  
MAINTAINER Amane Katagiri  
EXPOSE 25  
RUN apk add --update --no-cache postfix && \  
postconf mynetworks="172.17.0.0/16, 127.0.0.0/8" && \  
postconf inet_interfaces="all" && \  
postconf smtp_tls_security_level="may" && \  
postconf smtpd_banner="$myhostname ESMTP" && \  
postconf smtputf8_enable="no"  
COPY run.sh /run.sh  
CMD ["/run.sh"]  

