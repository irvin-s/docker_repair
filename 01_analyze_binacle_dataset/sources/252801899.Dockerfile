FROM cptactionhank/atlassian-jira  
ENV TERM=xterm  
LABEL org.freenas.interactive="false" \  
org.freenas.version="2" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8080" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8080:8080/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/var/atlassian/jira\", \  
\"descr\": \"JIRA Home Directory\" \  
}, \  
{ \  
\"name\": \"/opt/atlassian/jira/logs\", \  
\"descr\": \"JIRA Logs\" \  
} \  
]"

