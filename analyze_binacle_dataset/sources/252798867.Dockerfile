FROM httpd:2.4-alpine  
MAINTAINER David Seibert <d.seibert@s-v.de>  
  
  
ENV AUTH_NAME "Restricted access"  
ENV PROXY_URL http://www.network-tools.com/  
#ENV AUTH_LDAP_HOST  
#ENV AUTH_LDAP_BINDDN  
#ENV AUTH_LDAP_BINDPASS  
#ENV AUTH_LDAP_ALLOWED_USERS  
#ENV AUTH_USER  
#ENV AUTH_PASS  
RUN apk update && apk add apr-util-ldap  
  
RUN mkdir -p /app  
  
COPY start.sh /app/  
  
CMD ["/app/start.sh"]

