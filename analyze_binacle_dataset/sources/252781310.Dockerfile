FROM dinkel/openldap  
  
ENV SLAPD_PASSWORD ldap  
ENV SLAPD_DOMAIN coyoapp.com  
ENV SLAPD_ORGANIZATION "Coyo GmbH"  
COPY ./default-data.ldif /etc/ldap.dist/prepopulate/default-data.ldif  

