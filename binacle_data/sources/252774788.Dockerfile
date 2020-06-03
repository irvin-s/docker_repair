FROM osixia/openldap  
LABEL org.freenas.interactive="false" \  
org.freenas.version="0.0.1" \  
org.freenas.upgradeable="false" \  
org.freenas.command="" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="false" \  
org.freenas.port-mappings="389:389/tcp" \  
org.freenas.settings="[ \  
{ \  
\"name\": \"LDAP_ORGANISATION\", \  
\"desc\": \"example: mycompany\" \  
}, \  
{ \  
\"name\": \"LDAP_DOMAIN\", \  
\"desc\": \"example: www.fehlerproblem.de\" \  
}, \  
{ \  
\"name\": \"LDAP_ADMIN_PASSWORD\", \  
\"desc\": \"LDAP_ADMIN_PASSWORD\" \  
} \  
]" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/var/lib/ldap\", \  
\"descr\": \"Data storage\" \  
}, \  
{ \  
\"name\": \"/etc/ldap/slapd.d\", \  
\"descr\": \"Config storage\" \  
} \  
]"  
  
  

