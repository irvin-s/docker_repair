FROM ubuntu:16.04  
MAINTAINER michimau <mauro.michielon@eea.europa.eu>  
  
RUN apt-get update -y  
RUN apt-get install -y proftpd proftpd-mod-ldap vim  
  
COPY proftpd.conf /etc/proftpd/proftpd.conf  
RUN rm /etc/proftpd/ldap.conf  
COPY ssl.conf /etc/proftpd/conf.d/ssl.conf  
COPY ldap.conf /etc/proftpd/conf.d/ldap.conf  
  
COPY gioland_access_rights.conf /etc/proftpd/conf.d/gioland_access_rights.conf  
COPY sdi_access_rights.conf /etc/proftpd/conf.d/sdi_access_rights.conf  
  
RUN echo "LoadModule mod_ldap.c" >> /etc/proftpd/modules.conf  
RUN echo "TLS_REQCERT allow" > /etc/ldap/ldap.conf  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod a+x /entrypoint.sh  
  
ENV PASSIVE_PORTS="49200-49230"  
ENTRYPOINT ["/entrypoint.sh"]  
  
#EXPOSE 20 21 999 990 1026 1027 1028 1029 1030  
EXPOSE 990  

