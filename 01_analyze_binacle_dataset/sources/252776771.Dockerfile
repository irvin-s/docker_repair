FROM dlandon/zoneminder:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="latest" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.privileged="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="80" \  
org.freenas.web-ui-path="zm" \  
org.freenas.port-mappings="80:80/tcp,443:443/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Zoneminder config\" \  
}, \  
{ \  
\"name\": \"/var/cache/zoneminder\", \  
\"descr\": \"Zoneminder data\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"User ID\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"Group ID\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Timezone - eg Europe/London\", \  
\"optional\": true \  
} \  
]"  

