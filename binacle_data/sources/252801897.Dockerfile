FROM cptactionhank/atlassian-confluence  
ENV TERM=xterm  
LABEL org.freenas.interactive="false" \  
org.freenas.version="2" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8090" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8090:8090/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/var/atlassian/confluence\", \  
\"descr\": \"Confluence Home Directory\" \  
}, \  
{ \  
\"name\": \"/opt/atlassian/confluence/logs\", \  
\"descr\": \"Confluence Logs\" \  
} \  
]"

